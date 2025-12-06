# -*- coding: utf-8 -*-
"""
api_complex_heatmap_page
------------------------------------------------------------
API：抗藥性複合熱圖分析頁面
------------------------------------------------------------
"""

import os
import typing as ty
from typing import Tuple
from fastapi import APIRouter, Form, HTTPException
from pipeline.anti_pipeline_complex_heatmap import (
    AntiPipelineComplexHeatmap,
)


router = APIRouter(prefix="/complex_heatmap", tags=["Result"])


@router.post("")
async def complex_heatmap(
    token: ty.Optional[str] = Form(None),
    job_id: ty.Optional[str] = Form(None),
    show_main_heatmap: ty.Optional[str] = Form("true"),
):
    """
    建立或讀取 Complex Heatmap 結果

    Args:
        token (str, optional): 簽名 token（優先使用）
        job_id (str, optional): 任務識別碼 (例如 2024121600-FKRz-ToUr-Y3gnd412)
        show_main_heatmap (str): 是否顯示主熱圖（"true" 或 "false"）

    Returns:
        dict: 包含 HTML 與 TSV 路徑資訊的字典
    """
    # 確定要使用的 job_id（優先使用 token，如果沒有則使用 job_id）
    if not token and not job_id:
        raise HTTPException(status_code=422, detail="Either 'token' or 'job_id' parameter is required.")
    
    # 目前實現中，token 就是 job_id
    actual_job_id = token if token else job_id
    
    if not actual_job_id or not actual_job_id.strip():
        raise HTTPException(status_code=422, detail="Invalid token or job_id: empty value.")
    
    # 轉換 show_main_heatmap 字符串為布爾值
    show_main_heatmap_bool = show_main_heatmap.lower() == "true"
    
    try:
        pipeline = AntiPipelineComplexHeatmap(actual_job_id)
        result = pipeline.run(
            with_annotations=show_main_heatmap_bool, show_main_heatmap=show_main_heatmap_bool
        )

        html_path = result.get("html", "")
        html_annotated_path = result.get("html_annotated", "")
        pdf_annotated_path = result.get("pdf_annotated", "")
        jpg_annotated_path = result.get("jpg_annotated", "")
        summary_path = result.get("summary", "")
        output_dir = result.get("output_dir", "")

        # 除錯資訊輸出
        print(f"[DEBUG] job_id = {actual_job_id}")
        print(f"[DEBUG] html_path = {html_path}")
        print(f"[DEBUG] html_annotated_path = {html_annotated_path}")
        print(f"[DEBUG] pdf_annotated_path = {pdf_annotated_path}")
        print(f"[DEBUG] jpg_annotated_path = {jpg_annotated_path}")
        print(f"[DEBUG] summary_path = {summary_path}")
        print(f"[DEBUG] output_dir = {output_dir}")

        # 將實體檔案路徑轉為 /jobs/ URL (供前端使用)
        def to_static_url(file_path: str) -> str:
            """
            將後端檔案路徑轉為 /anti_form_jobs/ URL (同時支援 Windows 與 POSIX)。

            例如：
                D:\\project\\anti_form_jobs\\2024...\\Hybrid_AMR_Heatmap.html
            會被轉換為：
                /anti_form_jobs/2024.../Hybrid_AMR_Heatmap.html
            """
            if not file_path:
                return ""

            # 若已是 http(s) URL，直接回傳
            if file_path.startswith(("http://", "https://")):
                return file_path

            normalized = file_path.replace("\\", "/")

            # 已經是以 /anti_form_jobs/ 開頭的網址
            if normalized.startswith("/anti_form_jobs/"):
                return normalized

            # 移除前導斜線後再比對
            stripped = normalized.lstrip("/")
            if stripped.startswith("anti_form_jobs/"):
                return "/" + stripped

            marker = "/anti_form_jobs/"
            idx = normalized.lower().find(marker)
            if idx != -1:
                relative_path = normalized[idx + len(marker) :]
                return f"/anti_form_jobs/{relative_path}"

            return normalized

        # 狀態判斷邏輯（優先使用標註版）- 檢查文件是否存在
        def check_file_exists(file_path: str) -> Tuple[bool, int]:
            """檢查文件是否存在並返回文件大小"""
            if not file_path:
                return False, 0
            if os.path.isfile(file_path):
                try:
                    size = os.path.getsize(file_path)
                    return True, size
                except Exception:
                    return True, 0
            return False, 0

        html_annotated_exists, html_annotated_size = check_file_exists(
            html_annotated_path
        )
        html_exists, html_size = check_file_exists(html_path)
        pdf_exists, pdf_size = check_file_exists(pdf_annotated_path)
        jpg_exists, jpg_size = check_file_exists(jpg_annotated_path)
        summary_exists, summary_size = check_file_exists(summary_path)

        # 只返回存在的文件的 URL
        html_url = to_static_url(html_path) if html_exists else ""
        html_annotated_url = (
            to_static_url(html_annotated_path) if html_annotated_exists else ""
        )
        pdf_annotated_url = to_static_url(pdf_annotated_path) if pdf_exists else ""
        jpg_annotated_url = to_static_url(jpg_annotated_path) if jpg_exists else ""
        summary_url = to_static_url(summary_path) if summary_exists else ""

        # 除錯資訊：輸出文件存在狀態和大小
        print(f"[DEBUG] 文件存在狀態與大小：")
        print(
            f"  - HTML (annotated): {html_annotated_exists} ({html_annotated_size} bytes) -> {html_annotated_url}"
        )
        print(f"  - HTML: {html_exists} ({html_size} bytes) -> {html_url}")
        print(f"  - PDF: {pdf_exists} ({pdf_size} bytes) -> {pdf_annotated_url}")
        if pdf_exists:
            print(f"    PDF 文件路徑: {pdf_annotated_path}")
            print(f"    PDF URL 路徑: {pdf_annotated_url}")
        print(f"  - JPG: {jpg_exists} ({jpg_size} bytes) -> {jpg_annotated_url}")
        print(f"  - Summary: {summary_exists} ({summary_size} bytes) -> {summary_url}")

        if html_annotated_exists:
            status = "success"
        elif html_exists:
            status = "partial"
        elif summary_exists:
            status = "partial"
        else:
            status = "empty"

        return {
            "status": status,
            "job_id": actual_job_id,
            "html_path": html_url,
            "html_annotated_path": html_annotated_url,
            "pdf_annotated_path": pdf_annotated_url,
            "jpg_annotated_path": jpg_annotated_url,
            "summary_path": summary_url,
            "output_dir": output_dir,
        }

    except Exception as e:
        # 捕捉所有錯誤並以 500 返回，包含詳細錯誤原因與 traceback（便於除錯）
        import traceback

        error_message = f"Complex Heatmap 分析失敗：{str(e)}"
        print(f"[錯誤] {error_message}")
        traceback.print_exc()
        raise HTTPException(status_code=500, detail=error_message)
