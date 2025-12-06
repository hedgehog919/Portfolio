import os
import typing as ty

from fastapi import APIRouter, HTTPException
from pydantic import BaseModel

# 根資料夾位置 / Root folder for jobs
BASE_FOLDER = os.path.join(".", "anti_form_jobs")

# 建立 /search 路由 / Create API router with prefix "/search"
router = APIRouter(prefix="/search", tags=["search"])


class JobIDCheckResponse(BaseModel):
    """
    回應模型：Job ID 資料夾驗證結果
    Response model for folder existence check

    Attributes:
        exists (bool): True 表示資料夾存在 / True if folder exists
    """

    exists: bool


@router.get(
    "/check_jobid/{job_id}",
    response_model=JobIDCheckResponse,
    summary="檢查 Job ID 對應資料夾是否存在 / Check folder existence",
)
async def check_job_id(
    job_id: str,  # 從 URL Path 直接取得 job_id
) -> JobIDCheckResponse:
    """
    驗證傳入的 job_id 是否對應到 BASE_FOLDER 下的資料夾。
    Check if a directory named job_id exists under BASE_FOLDER.

    Args:
        job_id (str): 工作識別碼，用於對應資料夾名稱 / Job identifier for folder lookup

    Returns:
        JobIDCheckResponse: 回傳 exists 欄位表示資料夾是否存在
                            Response with 'exists' indicating folder existence
    """
    folder_path = os.path.join(BASE_FOLDER, job_id)
    exists = os.path.isdir(folder_path)
    return JobIDCheckResponse(exists=exists)
