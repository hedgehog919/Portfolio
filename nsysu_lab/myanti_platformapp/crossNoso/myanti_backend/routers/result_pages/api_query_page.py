import os
import typing as ty
from pathlib import Path

from fastapi import HTTPException

# 根路徑
# 調整 BASE_DIR 取得 myanti_backend 根目錄（向上三層：result_pages -> routers -> myanti_backend）
BASE_DIR = Path(__file__).resolve().parent.parent.parent
BASE_FOLDER = str(BASE_DIR / "anti_form_jobs")


def parse_query_table(job_id: str) -> ty.List[ty.List[ty.Optional[str]]]:
    """
    Parse query_table.tsv 並檢查每列欄位數是否一致。

    Args:
        job_id (str): 工作識別碼

    Returns:
        List[List[Optional[str]]]: 二維字串列表

    Raises:
        HTTPException: 檔案不存在、為空或欄位數不一致
    """
    path = os.path.join(BASE_FOLDER, job_id, "3.abProfilesCmp", "query_table.tsv")
    if not os.path.isfile(path):
        raise HTTPException(status_code=404, detail="找不到 query_table.tsv 檔案")

    lines = open(path, "r", encoding="utf-8").read().splitlines()
    if not lines:
        raise HTTPException(status_code=500, detail="query_table.tsv 為空檔案")

    expected = len(lines[0].split("\t"))
    table: ty.List[ty.List[ty.Optional[str]]] = []
    for idx, ln in enumerate(lines, start=1):
        cols = ln.split("\t")
        if len(cols) != expected:
            raise HTTPException(
                status_code=500,
                detail=f"query_table.tsv 第 {idx} 列欄位數不符 (預期 {expected}，實際 {len(cols)})",
            )
        table.append(cols)
    return table
