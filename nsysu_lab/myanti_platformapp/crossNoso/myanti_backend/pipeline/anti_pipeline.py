# anti_pipeline.py

import os
import time
import subprocess
import typing as ty
import csv

# -----------------------------------------------------------------------------
# 環境變數設定
# -----------------------------------------------------------------------------
# 設定時區為 Asia/Taipei，使所有 time 模組的本地時間函式生效（僅限 Unix 系統）
os.environ["TZ"] = "Asia/Taipei"
try:
    time.tzset()
except AttributeError:
    # Windows 平台可能不支援 tzset()，忽略此錯誤即可
    pass

# 覆寫 PATH，讓 subprocess.run() 可找到所有所需外部工具
os.environ["PATH"] = (
    "/home/chieh/antibiogram_platform/bin:"
    "/home/chieh/eggNOG/eggnog-mapper:"
    "/home/chieh/bin/ncbi-blast-2.8.1+/bin:"
    "/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:"
    "/home/ngp/R-4.3.2"
)


def ensure_dir(path: str) -> None:
    """
    確保某個資料夾存在，若不存在則建立。
    """
    os.makedirs(path, exist_ok=True)


def run_pipeline(job_dir: str) -> None:
    """
    後端完整管線，包含：
      1. Taxonomic Assignment
      2. Allelic profiling (若常見菌則進一步做 cgMLST、繪圖)
      3. Antibiogram 比對
      4. 產生 complete_ok

    假設：
      - contigFile.fa 已存在於 job_dir
      - formData.json 包含 email 等欄位
      - 所有 Perl/R 工具已在 PATH 中

    Args:
        job_dir (str): 完整工作目錄路徑
    Returns:
        None
    """
    # 使用絕對路徑避免路徑解析問題
    job_dir = os.path.abspath(job_dir)
    fasta_path = os.path.join(job_dir, "contigFile.fa")
    formdata_path = os.path.join(job_dir, "formData.json")
    complete_flag = os.path.join(job_dir, "complete_ok")

    # 讀取 formData.json，抓取 email
    email = ""
    try:
        import json

        with open(formdata_path, "r", encoding="utf-8") as f:
            data = json.load(f)
            email = data.get("email", "") or ""
    except Exception:
        email = ""

    # 1. Taxonomic Assignment 物種分類：呼叫 Perl 腳本進行分類，比對指定的 SILVA 資料庫（查詢用），非輸出路徑
    try:
        out_dir1 = os.path.join(job_dir, "1.taxAssign")
        ensure_dir(out_dir1)
        cmd1 = [
            "1.Taxonomic-Assignments.pl",
            "-i",
            fasta_path,
            "-d",
            "/home/chieh/antibiogram_platform/databases/silva/silva_db_all",
            "-o",
            out_dir1,
            "-p",
            "12",
        ]
        subprocess.run(cmd1, check=True)
        # 產生標記檔 taxAssign_ok
        open(os.path.join(job_dir, "taxAssign_ok"), "w").close()
    except Exception as e:
        # 若此步驟失敗，直接結束並不產生 complete_ok
        # 可以在 job_dir 下寫一個 error.log 供排錯
        with open(os.path.join(job_dir, "error.log"), "w", encoding="utf-8") as ef:
            ef.write(f"Taxonomic Assignment failed:\n{str(e)}\n")
        return

    # 2. 解析 taxAssign.result 取得物種簡寫
    try:
        result_file = os.path.join(job_dir, "1.taxAssign", "taxAssign.result")
        with open(result_file, "r", encoding="utf-8") as tf:
            first_line = tf.readline().strip()
        sp_full = first_line.split("\t")[0]  # e.g. "Acinetobacter_baumannii"
        sp_parts = sp_full.split("_", 1)
        sp_key = f"{sp_parts[0]}_{sp_parts[1]}" if len(sp_parts) == 2 else sp_full

        mapping: ty.Dict[str, str] = {
            "Acinetobacter_baumannii": "AB",
            "Enterococcus_faecium": "EF",
            "Klebsiella_pneumoniae": "KP",
            "Pseudomonas_aeruginosa": "PA",
            "Staphylococcus_aureus": "SA",
        }
        organism = mapping.get(sp_key, None)
    except Exception as e:
        organism = None

    # 3. 根據物種簡寫決定執行流程
    if organism in {"AB", "EF", "KP", "PA", "SA"}:
        # 3A. 若是五大常見菌
        # 3A-1: Query Profiling 等位基因分析：呼叫外部 Perl 腳本，-d 參數指定 cgMLST 資料庫查詢用的 DB 路徑
        try:
            out_dir2 = os.path.join(job_dir, "2.QueryProfile")
            ensure_dir(out_dir2)
            cmd2 = [
                "2.Query-Profiling.pl",
                "-i",
                fasta_path,
                "-d",
                "/home/chieh/antibiogram_platform/databases/cgMLST_db",
                "-b",
                organism,
                "-o",
                out_dir2,
                "-p",
                "12",
            ]
            subprocess.run(cmd2, check=True)
            open(os.path.join(job_dir, "queryProfile_ok"), "w").close()
        except Exception as e:
            with open(os.path.join(job_dir, "error.log"), "a", encoding="utf-8") as ef:
                ef.write(f"Query-Profiling failed:\n{str(e)}\n")
            return

        # 3A-2: Antibiogram 比對 (alleticDist 版本)
        try:
            out_dir3 = os.path.join(job_dir, "3.abProfilesCmp")
            ensure_dir(out_dir3)
            allele_matrix = os.path.join(out_dir2, "alleleMatrix.1")
            cmd3 = [
                "3.Antibiogram-Comparison-alleticDist.pl",
                "-i",
                fasta_path,
                "-j",
                allele_matrix,
                "-b",
                organism,
                "-o",
                out_dir3,
                "-p",
                "12",
            ]
            subprocess.run(cmd3, check=True)
            open(os.path.join(job_dir, "abProfilesCmp_ok"), "w").close()
        except Exception as e:
            with open(os.path.join(job_dir, "error.log"), "a", encoding="utf-8") as ef:
                ef.write(f"Ab-Comparison-alleticDist failed:\n{str(e)}\n")
            return

        # 3A-3: cgMLST profiling：呼叫外部 Perl 腳本，
        # -d 參數指定 cgMLST 資料庫查詢用的 DB 路徑；
        # -h 參數指定上一步 hits_table.tsv 的路徑；-b 參數指定菌種簡寫；
        # -o 參數指定輸出資料夾，-p 指定執行緒數
        try:
            out_dir4 = os.path.join(job_dir, "4.cgProfiles")
            ensure_dir(out_dir4)
            hits_table = os.path.join(out_dir3, "hits_table.tsv")
            cmd4 = [
                "4.cgMLST-Profiler-alleticDist.pl",
                "-i",
                out_dir2,
                "-d",
                "/home/chieh/antibiogram_platform/databases/cgMLST_db",
                "-h",
                hits_table,
                "-b",
                organism,
                "-o",
                out_dir4,
                "-p",
                "12",
            ]
            subprocess.run(cmd4, check=True)
            open(os.path.join(job_dir, "cgProfiles_ok"), "w").close()
        except Exception as e:
            with open(os.path.join(job_dir, "error.log"), "a", encoding="utf-8") as ef:
                ef.write(f"cgMLST-Profiler failed:\n{str(e)}\n")
            return

        # 3A-4: Dendrogram & Heatmap 繪製
        try:
            out_dir5 = os.path.join(job_dir, "5.DendroPlot")
            ensure_dir(out_dir5)
            cmd5 = ["5.Dendro-Plotter_NJ.pl", "-i", out_dir4, "-o", out_dir5]
            subprocess.run(cmd5, check=True)
            # Heatmap
            cmd_heatmap = [
                "/home/ngp/R-4.3.2/bin/Rscript",
                "/home/ngp/R_code/5NosoAE/12_13_heatmap_new.R",
                os.path.abspath(job_dir),
            ]
            subprocess.run(cmd_heatmap, check=True)
            open(os.path.join(job_dir, "DendroPlot_ok"), "w").close()
        except Exception as e:
            with open(os.path.join(job_dir, "error.log"), "a", encoding="utf-8") as ef:
                ef.write(f"Dendrogram or Heatmap failed:\n{str(e)}\n")
            return

    # 3B. 若非五大常見菌，直接做簡化版 Antibiogram 比對
    else:
        try:
            out_dir3 = os.path.join(job_dir, "3.abProfilesCmp")
            ensure_dir(out_dir3)
            cmd3_simple = [
                "3.Antibiogram-Comparison.pl",
                "-i",
                fasta_path,
                "-o",
                out_dir3,
                "-p",
                "12",
            ]
            subprocess.run(cmd3_simple, check=True)
            open(os.path.join(job_dir, "abProfilesCmp_ok"), "w").close()
        except Exception as e:
            with open(os.path.join(job_dir, "error.log"), "a", encoding="utf-8") as ef:
                ef.write(f"Simple Ab-Comparison failed:\n{str(e)}\n")
            return

        # 解析 hits_summary.tsv，取得每筆菌株紀錄的詳細國家欄位
        try:
            hits_summary_path = os.path.join(
                out_dir3, "hits_summary.tsv"  # 取得 hits_summary.tsv 的路徑
            )
            # 讀取 hits_summary.tsv
            with open(hits_summary_path, "r", encoding="utf-8") as f:
                reader = csv.reader(f, delimiter="\t")  # 使用 tab 作為分隔符
                next(reader)  # 跳過標題行
                # 解析每一行，取得國家欄位
                for row in reader:
                    if len(row) < 7:  # 欄位數不足，跳過
                        continue
                    country = row[0]  # 取得國家名稱
                    # 進一步處理 country 欄位，例如存入資料結構
        except Exception as e:  # 解析 hits_summary 失敗
            with open(os.path.join(job_dir, "error.log"), "a", encoding="utf-8") as ef:
                ef.write(f"Parsing hits_summary failed:\n{str(e)}\n")  # 直接結束流程
            return

    # 4. 標記完成：在 job_dir 下建立 complete_ok
    open(complete_flag, "w").close()
    # 產生空的 country 檔案，內容為空字串，避免舊腳本存取錯誤
    open(os.path.join(job_dir, "country"), "w", encoding="utf-8").close()
