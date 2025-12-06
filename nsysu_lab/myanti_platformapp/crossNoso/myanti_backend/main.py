import os
import sys
import uvicorn
from pathlib import Path
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
import threading
import time
import socket
import subprocess
from typing import Optional

# Optional: auto-run heatmap on startup. Configure via environment variables:
#   HEATMAP_AUTO_RUN=1
#   HEATMAP_TSV_PATH=/absolute/path/to/heatmap_data.tsv    # OR
#   HEATMAP_JOB_ID=<job_id>
#   HEATMAP_OUTDIR=/path/to/outdir
#   HEATMAP_COLORCFG=/path/to/colors.json
HEATMAP_AUTO_RUN = os.environ.get("HEATMAP_AUTO_RUN", "0").lower() in (
    "1",
    "true",
    "yes",
)
HEATMAP_TSV_PATH: Optional[str] = os.environ.get("HEATMAP_TSV_PATH")
HEATMAP_JOB_ID: Optional[str] = os.environ.get("HEATMAP_JOB_ID")
HEATMAP_OUTDIR: Optional[str] = os.environ.get("HEATMAP_OUTDIR")
HEATMAP_COLORCFG: Optional[str] = os.environ.get("HEATMAP_COLORCFG")

# 確保當前目錄（myanti_backend）已加入 sys.path，這樣相對導入才能正常工作
# 例如：from routers import ... 或 from pipeline import ...
_file_dir = os.path.dirname(os.path.abspath(__file__))
# 將當前目錄（myanti_backend）加入 sys.path，這樣相對導入才能工作
if _file_dir not in sys.path:
    sys.path.insert(0, _file_dir)

# 匯入系統相關 API 路由模組
from routers import api_anitform
from routers import api_result
from routers import api_search

description = """
<strong><div class="small-text" style="font-size: 14px;">
    System Description
</div></strong>
這是一個示範用的 FastAPI 應用程式，旨在建立一個抗藥性分析平台的 API。<br>
這個平台提供多種功能來協助醫療專業人士與研究人員分析不同病原體的抗藥性資料。<br>
我們的目標是透過先進的數據分析與可視化工具，使抗藥性問題的識別與控制更加高效和準確。<br>

平台的主要功能包括：<br>
1. 抗藥性基因與抗生素檢索（Resistance Genes & Antibiotics）<br>
2. AMR 識別資料查詢（AMR Profile Search）<br>
3. 抗藥性熱圖（Heatmap of Resistance）<br>
4. 地理分佈分析（Geographical Distribution）<br>
5. cgMLST 分析（cgMLST Analysis）<br>

這些功能將協助使用者深入了解病原體的抗藥性特徵，並提供可操作的數據支持以便於臨床決策及研究。<br>
透過這個 API，用戶可以輕鬆進行數據查詢與分析，並生成相應的可視化結果，從而提高抗藥性監控的精準度。<br> 

"""


app = FastAPI(
    title="crossNoso",
    version="1.0",
    # summary="My Anti",
    description=description,
)

# 加入 CORSMiddleware，設定允許來自特定來源的跨域請求
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# 將 anti_form_jobs 目錄掛載為靜態檔案服務，讓前端可以透過 /anti_form_jobs/... 存取輸出結果
# 使用絕對路徑確保在容器中也能正確找到目錄
BASE_DIR = Path(__file__).resolve().parent
ANTI_FORM_JOBS_DIR = BASE_DIR / "anti_form_jobs"

# 也檢查容器內的掛載路徑（如果存在）
CONTAINER_JOBS_DIR = Path("/app/myanti_backend/anti_form_jobs")

# 優先使用容器掛載路徑，如果不存在則使用相對路徑
if CONTAINER_JOBS_DIR.exists():
    static_dir = str(CONTAINER_JOBS_DIR)
    print(f"[INFO] Using container mount path: {static_dir}")
elif ANTI_FORM_JOBS_DIR.exists():
    static_dir = str(ANTI_FORM_JOBS_DIR)
    print(f"[INFO] Using relative path: {static_dir}")
else:
    static_dir = None
    print(f"[WARN] anti_form_jobs directory not found at:")
    print(f"  - Container path: {CONTAINER_JOBS_DIR}")
    print(f"  - Relative path: {ANTI_FORM_JOBS_DIR}")
    print("[WARN] static mount skipped.")

if static_dir:
    try:
        app.mount(
            "/anti_form_jobs",
            StaticFiles(directory=static_dir, html=True),
            name="anti_form_jobs",
        )
        print(f"[INFO] Static files successfully mounted from: {static_dir}")
    except Exception as e:
        print(f"[ERROR] Failed to mount static files: {e}")
        import traceback

        traceback.print_exc()

# 載入各模組的 API 路由
app.include_router(api_anitform.router)
app.include_router(api_result.router)
app.include_router(api_search.router)

if __name__ == "__main__":
    # If requested via environment, launch heatmap generation in a background thread
    if HEATMAP_AUTO_RUN and (HEATMAP_TSV_PATH or HEATMAP_JOB_ID):

        def _run_heatmap_background():
            try:
                print(
                    f"[INFO] Auto-run heatmap triggered. TSV={HEATMAP_TSV_PATH}, JOB_ID={HEATMAP_JOB_ID}"
                )
                # import locally to avoid top-level dependency if not used
                from pipeline.anti_pipeline_complex_heatmap import (
                    run_from_tsv,
                    AntiPipelineComplexHeatmap,
                )

                if HEATMAP_TSV_PATH:
                    outdir = HEATMAP_OUTDIR or os.path.join(
                        os.getcwd(), "heatmap_auto_out"
                    )
                    os.makedirs(outdir, exist_ok=True)
                    try:
                        html = run_from_tsv(
                            HEATMAP_TSV_PATH, outdir=outdir, colorcfg=HEATMAP_COLORCFG
                        )
                        print(f"[INFO] Auto heatmap generated: {html}")
                    except Exception as e:
                        print("[ERROR] Auto-run from TSV failed:", e)
                else:
                    # run by job id
                    try:
                        p = AntiPipelineComplexHeatmap(
                            job_id=HEATMAP_JOB_ID, color_config=HEATMAP_COLORCFG
                        )
                        res = p.run()
                        print("[INFO] Auto heatmap run result:", res)
                    except Exception as e:
                        print("[ERROR] Auto-run by job id failed:", e)
            except Exception as ex:
                print("[ERROR] Unexpected error in heatmap background thread:", ex)

        t = threading.Thread(target=_run_heatmap_background, daemon=True)
        t.start()

    # 檢查並處理端口佔用問題
    def check_and_free_port(port: int):
        """檢查端口是否被佔用，如果被佔用則嘗試釋放"""
        # 先嘗試綁定端口來檢查是否可用
        test_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        test_sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        port_in_use = False

        try:
            test_sock.bind(("0.0.0.0", port))
            test_sock.close()
            print(f"[INFO] 端口 {port} 可用")
        except OSError:
            # 端口被佔用
            port_in_use = True
            test_sock.close()
            print(f"[WARN] 端口 {port} 已被佔用，嘗試釋放...")

            # 嘗試找到並殺掉佔用端口的進程
            try:
                # 使用 lsof 找到佔用端口的進程（Linux）
                result = subprocess.run(
                    ["lsof", "-ti", f":{port}"],
                    capture_output=True,
                    text=True,
                )
                if result.returncode == 0 and result.stdout.strip():
                    pids = result.stdout.strip().split("\n")
                    for pid in pids:
                        if pid and pid.strip():
                            print(f"[INFO] 終止進程 PID: {pid.strip()}")
                            subprocess.run(["kill", "-9", pid.strip()], check=False)
                    time.sleep(2)  # 等待進程終止
                    # 再次檢查端口是否已釋放
                    verify_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                    verify_sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
                    try:
                        verify_sock.bind(("0.0.0.0", port))
                        verify_sock.close()
                        print(f"[INFO] 端口 {port} 已成功釋放並可用")
                    except OSError:
                        verify_sock.close()
                        print(f"[ERROR] 端口 {port} 仍然被佔用，請手動檢查")
                else:
                    # 如果沒有 lsof，嘗試使用 fuser
                    try:
                        subprocess.run(
                            ["fuser", "-k", f"{port}/tcp"],
                            capture_output=True,
                            check=False,
                        )
                        time.sleep(2)
                        # 再次檢查端口是否已釋放
                        verify_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                        verify_sock.setsockopt(
                            socket.SOL_SOCKET, socket.SO_REUSEADDR, 1
                        )
                        try:
                            verify_sock.bind(("0.0.0.0", port))
                            verify_sock.close()
                            print(f"[INFO] 端口 {port} 已成功釋放並可用")
                        except OSError:
                            verify_sock.close()
                            print(f"[ERROR] 端口 {port} 仍然被佔用")
                    except FileNotFoundError:
                        print(
                            f"[WARN] 無法自動釋放端口 {port}，請手動檢查並終止佔用該端口的進程"
                        )
                        print(f"[WARN] 可以使用命令: lsof -ti :{port} | xargs kill -9")
            except FileNotFoundError:
                # 如果沒有 lsof，嘗試使用 fuser
                try:
                    subprocess.run(
                        ["fuser", "-k", f"{port}/tcp"],
                        capture_output=True,
                        check=False,
                    )
                    time.sleep(2)
                    # 再次檢查端口是否已釋放
                    verify_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                    verify_sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
                    try:
                        verify_sock.bind(("0.0.0.0", port))
                        verify_sock.close()
                        print(f"[INFO] 端口 {port} 已成功釋放並可用")
                    except OSError:
                        verify_sock.close()
                        print(f"[ERROR] 端口 {port} 仍然被佔用")
                except FileNotFoundError:
                    print(
                        f"[WARN] 無法自動釋放端口 {port}，請手動檢查並終止佔用該端口的進程"
                    )
                    print(f"[WARN] 可以使用命令: fuser -k {port}/tcp")
            except Exception as e:
                print(f"[WARN] 釋放端口時發生錯誤: {e}")
                import traceback

                traceback.print_exc()

    # 在啟動前檢查端口
    PORT = 40000

    # 檢查是否已經有 uvicorn 進程在運行
    try:
        result = subprocess.run(
            ["pgrep", "-f", "uvicorn.*main:app"],
            capture_output=True,
            text=True,
        )
        if result.returncode == 0 and result.stdout.strip():
            pids = result.stdout.strip().split("\n")
            print(f"[WARN] 檢測到已有 uvicorn 進程在運行 (PIDs: {', '.join(pids)})")
            print(f"[WARN] 這可能是因為：")
            print(f"[WARN]   1. Dockerfile 的 CMD 已自動啟動服務")
            print(f"[WARN]   2. start.sh 腳本已在背景啟動服務")
            print(f"[WARN]   3. 之前手動啟動的服務仍在運行")
            print(f"[WARN] 建議：")
            print(f"[WARN]   - 如果容器已通過 CMD 啟動服務，無需再執行 python main.py")
            print(f"[WARN]   - 或先停止現有服務：kill -9 {' '.join(pids)}")
            print(f"[WARN] 正在嘗試釋放端口並重新啟動...")
            # 嘗試終止這些進程
            for pid in pids:
                if pid.strip():
                    try:
                        subprocess.run(
                            ["kill", "-9", pid.strip()],
                            check=False,
                            capture_output=True,
                        )
                        print(f"[INFO] 已終止進程 PID: {pid.strip()}")
                    except Exception as e:
                        print(f"[WARN] 無法終止進程 {pid.strip()}: {e}")
            time.sleep(2)  # 等待進程終止
    except FileNotFoundError:
        # pgrep 不可用，跳過檢查
        pass

    check_and_free_port(PORT)

    # 使用模組匯入字串執行，確保 uvicorn 和套件匯入行為一致。
    # 啟用訪問日誌以便更輕鬆地調試傳入的請求（顯示客戶端 IP），並設置除錯日誌級別。
    uvicorn.run(
        "main:app",
        host="0.0.0.0",
        port=PORT,
        reload=True,
        log_level="debug",
        access_log=True,
    )
