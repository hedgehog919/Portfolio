# result/api_heatmap_page.py
import os
import json
import typing as ty
from pathlib import Path
from fastapi import HTTPException

# 任務資料夾根目錄
# 調整 BASE_DIR 取得 myanti_backend 根目錄（向上三層：result_pages -> routers -> myanti_backend）
BASE_DIR = Path(__file__).resolve().parent.parent.parent
BASE_FOLDER = str(BASE_DIR / "anti_form_jobs")


# =============================
# 熱圖資料讀取主功能
# =============================
def load_heatmap_data(
    job_id: str,
) -> ty.Tuple[
    ty.List[ty.Dict[str, ty.Any]],  # series
    ty.List[str],  # options_ranges
    str,  # gcaCode
    str,  # genome_file
    str,  # taxonomy
]:
    """
    依據 job_id 讀取分析結果檔案，組合 heatmap 需要的資料結構。
    包含：series, options_ranges, gcaCode, genome_file, taxonomy。
    若有檔案缺失或格式錯誤，直接拋出 HTTPException。
    """
    base = os.path.join(BASE_FOLDER, job_id)

    # 1. 讀取 formData.json 取得 gcaCode
    form_path = os.path.join(base, "formData.json")
    if not os.path.isfile(form_path):
        raise HTTPException(404, "找不到 formData.json")
    with open(form_path, "r", encoding="utf-8") as f:
        formdata = json.load(f)
    gca_code = formdata.get("gcaCode", "")

    # 2. 讀取 contigFile.fa 取得 genome_file 基因體內容
    genome_path = os.path.join(base, "contigFile.fa")
    if not os.path.isfile(genome_path):
        raise HTTPException(404, "找不到 contigFile.fa")
    with open(genome_path, "r", encoding="utf-8") as f:
        genome_file = f.read()

    # 3. 讀取 taxonomy 分類資訊（若有）
    tax_path = os.path.join(base, "1.taxAssign", "taxAssign.result")
    taxonomy = ""
    if os.path.isfile(tax_path):
        first = open(tax_path, "r", encoding="utf-8").readline().strip()
        if first:
            taxonomy = first.split()[0].replace("_", " ")

    # 4. 讀取 hits_profile.tsv 解析 heatmap 主體資料
    profile_path = os.path.join(base, "3.abProfilesCmp", "hits_profile.tsv")
    if not os.path.isfile(profile_path):
        raise HTTPException(404, "找不到 hits_profile.tsv")
    lines = open(profile_path, "r", encoding="utf-8").read().splitlines()
    if not lines:
        raise HTTPException(500, "hits_profile.tsv 為空")
    header = lines[0].split("\t")
    if len(header) < 2:
        raise HTTPException(500, "hits_profile.tsv 標題不足")
    options_ranges = header[1:]

    # 解析每一行資料，組成 series 結構
    series: ty.List[ty.Dict[str, ty.Any]] = []
    for ln in reversed(lines[1:]):
        parts = ln.split("\t")
        data = []
        for name, val in zip(options_ranges, parts[1:]):
            try:
                y = round(float(val), 2)
            except ValueError:
                y = None
            data.append({"x": name, "y": y})
        series.append({"name": parts[0], "data": data})

    return series, options_ranges, gca_code, genome_file, taxonomy
