import os
import io
import base64
import typing as ty
from pathlib import Path

from fastapi import HTTPException
from PIL import Image

# 根路徑
# 調整 BASE_DIR 取得 myanti_backend 根目錄（向上三層：result_pages -> routers -> myanti_backend）
BASE_DIR = Path(__file__).resolve().parent.parent.parent
BASE_FOLDER = str(BASE_DIR / "anti_form_jobs")


def load_search_data(
    job_id: str,
) -> ty.Tuple[ty.List[ty.List[ty.Optional[str]]], str, str]:
    """
    解析 hits_table.tsv，並將 hits_hist_1.png、hits_hist_2.png 轉為 Base64。

    Args:
        job_id (str): 工作識別碼

    Returns:
        Tuple[
            List[List[Optional[str]]],  # hits_table
            str,                         # hits_hist_1
            str                          # hits_hist_2
        ]

    Raises:
        HTTPException: 檔案不存在或讀取失敗
    """
    base = os.path.join(BASE_FOLDER, job_id, "3.abProfilesCmp")

    # hits_table.tsv → hits_table
    table_path = os.path.join(base, "hits_table.tsv")
    if not os.path.isfile(table_path):
        raise HTTPException(status_code=404, detail="找不到 hits_table.tsv 檔案")
    lines = open(table_path, "r", encoding="utf-8").read().splitlines()
    if not lines:
        raise HTTPException(status_code=500, detail="hits_table.tsv 為空檔案")

    expected = len(lines[0].split("\t"))
    hits_table: ty.List[ty.List[ty.Optional[str]]] = []
    for idx, ln in enumerate(lines, start=1):
        cols = ln.split("\t")
        if len(cols) != expected:
            raise HTTPException(
                status_code=500,
                detail=f"hits_table.tsv 第 {idx} 列欄位數不符 (預期 {expected}，實際 {len(cols)})",
            )
        hits_table.append(cols)

    # encode histograms
    def _encode(fname: str) -> str:
        path = os.path.join(base, fname)
        if not os.path.isfile(path):
            raise HTTPException(status_code=404, detail=f"找不到圖片：{fname}")
        try:
            with Image.open(path) as img:
                buf = io.BytesIO()
                img.save(buf, format=img.format)
                return base64.b64encode(buf.getvalue()).decode("utf-8")
        except Exception as e:
            raise HTTPException(status_code=500, detail=f"圖片讀取失敗: {e}")

    hist1 = _encode("hits_hist_1.png")
    hist2 = _encode("hits_hist_2.png")

    return hits_table, hist1, hist2
