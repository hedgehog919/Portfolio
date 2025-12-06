# api_result：整合 heatmap、query table、search hits、地圖等分析結果


import os
import json
import typing as ty
from pathlib import Path
from fastapi import APIRouter, HTTPException, Form
from pydantic import BaseModel

# 匯入結果的資料處理函式
from routers.result_pages.api_heatmap_page import load_heatmap_data
from routers.result_pages.api_map_page import load_map_data
from routers.result_pages.api_query_page import parse_query_table
from routers.result_pages.api_search_page import load_search_data


# 分析結果根目錄
# 調整 BASE_DIR 取得 myanti_backend 根目錄（向上兩層：routers -> myanti_backend）
BASE_DIR = Path(__file__).resolve().parent.parent
BASE_FOLDER = str(BASE_DIR / "anti_form_jobs")
# FastAPI 路由設定
router = APIRouter(prefix="/result", tags=["result"])


# API 回傳資料模型
class ResultOutputModel(BaseModel):
    job_id: str  # 工作識別碼
    series: ty.List[ty.Any]  # heatmap 資料
    options_ranges: ty.List[str]  # heatmap 選項範圍
    gcaCode: str  # GCA 基因組識別代碼
    genome_file: str  # 基因組檔案
    taxonomy: str  # 系統分類
    query_table: ty.List[ty.List[ty.Optional[str]]]  # 查詢表格
    hits_table: ty.List[ty.List[ty.Optional[str]]]  # 搜尋表格
    hits_hist_1: str  # 搜尋結果直方圖 1
    hits_hist_2: str  # 搜尋結果直方圖 2
    geojson: ty.Dict[str, ty.Any]  # 地圖 GeoJSON 資料
    marker: ty.List[float]  # 地圖標記座標
    location: str  # 標記位置
    marker_country: str  # 標記點國家
    pie_chart_data: ty.List[ty.List[ty.Any]]  # 圓餅圖資料


@router.post("/result", response_model=ResultOutputModel)
async def get_result(
    token: ty.Optional[str] = Form(None), job_id: ty.Optional[str] = Form(None)
) -> ResultOutputModel:
    """
    合併 /result/result 和 /result/piechart 的邏輯，返回所有分析結果，包括圓餅圖數據。

    支援 token 或 job_id 參數（優先使用 token）
    """

    # 確定要使用的 job_id（優先使用 token，如果沒有則使用 job_id）
    if not token and not job_id:
        raise HTTPException(
            status_code=422, detail="Either 'token' or 'job_id' parameter is required."
        )

    # 目前實現中，token 就是 job_id
    actual_job_id = token if token else job_id

    if not actual_job_id or not actual_job_id.strip():
        raise HTTPException(
            status_code=422, detail="Invalid token or job_id: empty value."
        )

    # 檢查分析資料夾與完成標記
    folder = os.path.join(BASE_FOLDER, actual_job_id)
    if not os.path.exists(folder):
        raise HTTPException(status_code=404, detail="Job ID not found.")
    if not os.path.exists(os.path.join(folder, "complete_ok")):
        raise HTTPException(
            status_code=402, detail="Job not completed yet. Please wait."
        )

    # 1.取得 heatmap 相關資料
    series, options_ranges, gca_code, genome_file, taxonomy = load_heatmap_data(
        actual_job_id
    )

    # 2.取得 query table
    query_table = parse_query_table(actual_job_id)

    # 3.取得搜尋表格 (hits_table)與直方圖(histogram)
    hits_table, hist1, hist2 = load_search_data(actual_job_id)

    # 4.取得地圖資料（失敗則回傳預設值）
    try:
        geojson, marker, marker_country, pie_chart_data = load_map_data(
            actual_job_id, BASE_FOLDER
        )
        features = geojson.get("features", [])  # 提取 features
    except Exception as e:
        print(f"Map data load error: {e}")
        geojson = {"type": "FeatureCollection", "features": []}
        marker = [0.0, 0.0]
        marker_country = "America"
        features = []  # 如果發生錯誤，設置 features 為空列表
        pie_chart_data = {"labels": [], "data": []}  # 確保 pie_chart_data 有預設值

    # 5.讀取表單 location 欄位
    form_path = os.path.join(folder, "formData.json")
    location = ""
    if os.path.exists(form_path):
        try:
            with open(form_path, "r", encoding="utf-8") as f:
                form_data = json.load(f)
                location = form_data.get("location", "")
        except Exception as e:
            print(f"formData.json parse error: {e}")
            location = ""

    # 7.組合所有分析結果並回傳
    return ResultOutputModel(
        job_id=actual_job_id,  # 工作識別碼
        series=series,  # heatmap 資料
        options_ranges=options_ranges,  # heatmap 選項範圍
        gcaCode=gca_code,  # GCA 基因組識別代碼
        genome_file=genome_file,  # 基因組檔案
        taxonomy=taxonomy,  # 系統分類
        query_table=query_table,  # 查詢表格
        hits_table=hits_table,  # 搜尋表格
        hits_hist_1=hist1,  # 搜尋結果直方圖 1
        hits_hist_2=hist2,  # 搜尋結果直方圖 2
        geojson=geojson,  # 地圖 GeoJSON 資料
        marker=marker,  # 地圖標記座標
        location=location,  # 標記位置
        marker_country=marker_country,  # 標記點國家
        pie_chart_data=pie_chart_data,  # 圓餅圖資料
    )


# api_result：整合 Heatmap、Query Table、Search Hits、地圖與 Complex Heatmap 結果


import os
import importlib
import json
import typing as ty
import asyncio
from pathlib import Path
from fastapi import APIRouter, HTTPException, Form
from pydantic import BaseModel

print(f"[DEBUG] api_result 載入自：{__file__}")


# 分析結果根目錄
# 調整 BASE_DIR 取得 myanti_backend 根目錄（向上兩層：routers -> myanti_backend）
BASE_DIR = Path(__file__).resolve().parent.parent
BASE_FOLDER = str(BASE_DIR / "anti_form_jobs")
# FastAPI 路由設定
router = APIRouter(prefix="/result", tags=["result"])


# 自動載入所有 result_pages 內的路由模組
def auto_include_result_pages(router: APIRouter) -> None:
    """
    自動掃描 result_pages 目錄，尋找具備 router 物件的模組並掛載。

    Notes:
        - 僅匯入以 `api_` 開頭且為 `.py` 結尾的檔案。
        - 只掛載存在 `router = APIRouter()` 的模組。
    """
    import sys
    import importlib.util

    result_pages_dir = os.path.join(
        os.path.dirname(os.path.abspath(__file__)), "result_pages"
    )
    print(f"[DEBUG] 掃描路徑：{result_pages_dir}")
    print(f"[DEBUG] 該資料夾存在嗎？ {os.path.exists(result_pages_dir)}")
    print(f"[DEBUG] 當前 __package__: {__package__}")
    print(f"[DEBUG] sys.path[0]: {sys.path[0] if sys.path else 'None'}")

    for filename in os.listdir(result_pages_dir):
        print(f"[DEBUG] 找到檔案：{filename}")
        if not filename.startswith("api_") or not filename.endswith(".py"):
            continue

        module_name_base = filename[:-3]  # 移除 .py 後綴
        module_path = os.path.join(result_pages_dir, filename)
        full_module_name = f"routers.result_pages.{module_name_base}"
        module_loaded = False

        # 優先使用文件系統導入，這是最可靠的方式
        try:
            spec = importlib.util.spec_from_file_location(full_module_name, module_path)
            if spec and spec.loader:
                module = importlib.util.module_from_spec(spec)
                # 設置模組的 __package__ 和 __name__，確保導入能正確解析
                module.__package__ = "routers.result_pages"
                module.__name__ = full_module_name
                # 將模組加入 sys.modules，這樣其他模組可以導入它
                sys.modules[full_module_name] = module

                # 在執行模組前，確保 sys.path 包含 myanti_backend 目錄
                # 這樣模組內部的絕對導入（如 from pipeline import ...）能正常工作
                myanti_backend_dir = os.path.dirname(
                    os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
                )
                if myanti_backend_dir not in sys.path:
                    sys.path.insert(0, myanti_backend_dir)
                    print(f"[DEBUG] 已將 {myanti_backend_dir} 加入 sys.path")

                # 執行模組
                spec.loader.exec_module(module)
                if hasattr(module, "router"):
                    router.include_router(module.router)
                    print(f"[AutoMount] 掛載模組：{full_module_name}")
                    module_loaded = True
                else:
                    print(f"[DEBUG] 模組 {full_module_name} 沒有 router 屬性，跳過")
        except Exception as e:
            # 顯示更詳細的錯誤訊息
            error_msg = str(e)
            print(f"[警告] 模組 {full_module_name} 載入失敗：{error_msg}")
            # 如果錯誤訊息包含 myanti_backend，說明是導入路徑問題
            if "myanti_backend" in error_msg:
                print(
                    f"[DEBUG] 檢測到 myanti_backend 導入錯誤，這可能是模組內部導入問題"
                )
                print(f"[DEBUG] 模組路徑：{module_path}")
                print(f"[DEBUG] 模組名稱：{full_module_name}")
                print(f"[DEBUG] 當前 sys.path: {sys.path[:3]}")
                print(
                    f"[DEBUG] 模組 __package__: {module.__package__ if 'module' in locals() else 'N/A'}"
                )
            import traceback

            traceback.print_exc()

        if not module_loaded:
            print(f"[警告] 模組 {module_name_base} 無法載入")


# 匯入分析流程物件
from pipeline.anti_pipeline_complex_heatmap import (
    AntiPipelineComplexHeatmap,
)


# Pydantic 資料回傳模型
class ResultOutputModel(BaseModel):
    job_id: str  # 工作識別碼
    series: ty.List[ty.Any]  # heatmap 資料
    options_ranges: ty.List[str]  # heatmap 選項範圍
    gcaCode: str  # GCA 基因組識別代碼
    genome_file: str  # 基因組檔案
    taxonomy: str  # 系統分類
    query_table: ty.List[ty.List[ty.Optional[str]]]  # 查詢表格
    hits_table: ty.List[ty.List[ty.Optional[str]]]  # 搜尋表格
    hits_hist_1: str  # 搜尋結果直方圖 1
    hits_hist_2: str  # 搜尋結果直方圖 2
    geojson: ty.Dict[str, ty.Any]  # 地圖 GeoJSON 資料
    marker: ty.List[float]  # 地圖標記座標
    location: str  # 標記位置
    marker_country: str  # 標記點國家
    pie_chart_data: ty.List[ty.List[ty.Any]]  # 圓餅圖資料
    complex_heatmap_data: ty.List[ty.Any]  # Complex Heatmap 資料


@router.post("/result", response_model=ResultOutputModel)
async def get_result(
    token: ty.Optional[str] = Form(None), job_id: ty.Optional[str] = Form(None)
) -> ResultOutputModel:
    """
    整合所有分析結果：
    - Heatmap、Query Table、Search Result、地圖、Pie Chart、Complex Heatmap

    支援 token 或 job_id 參數（優先使用 token）
    """

    # 確定要使用的 job_id（優先使用 token，如果沒有則使用 job_id）
    if not token and not job_id:
        raise HTTPException(
            status_code=422, detail="Either 'token' or 'job_id' parameter is required."
        )

    # 目前實現中，token 就是 job_id
    actual_job_id = token if token else job_id

    if not actual_job_id or not actual_job_id.strip():
        raise HTTPException(
            status_code=422, detail="Invalid token or job_id: empty value."
        )

    # 檢查分析資料夾與完成標記
    folder = os.path.join(BASE_FOLDER, actual_job_id)
    if not os.path.exists(folder):
        raise HTTPException(status_code=404, detail="Job ID not found.")
    if not os.path.exists(os.path.join(folder, "complete_ok")):
        raise HTTPException(
            status_code=402, detail="Job not completed yet. Please wait."
        )

    # 匯入現有功能模組（保持原結構不動）
    from routers.result_pages.api_heatmap_page import load_heatmap_data
    from routers.result_pages.api_query_page import parse_query_table
    from routers.result_pages.api_search_page import load_search_data
    from routers.result_pages.api_map_page import load_map_data

    # 1.取得 heatmap 相關資料
    series, options_ranges, gca_code, genome_file, taxonomy = load_heatmap_data(
        actual_job_id
    )

    # 2.取得 query table
    query_table = parse_query_table(actual_job_id)

    # 3.取得搜尋表格 (hits_table)與直方圖(histogram)
    hits_table, hist1, hist2 = load_search_data(actual_job_id)

    # 4.取得地圖資料（失敗則回傳預設值）
    try:
        geojson, marker, marker_country, pie_chart_data = load_map_data(
            actual_job_id, BASE_FOLDER
        )
        features = geojson.get("features", [])  # 提取 features
    except Exception as e:
        print(f"Map data load error: {e}")
        geojson = {"type": "FeatureCollection", "features": []}
        marker = [0.0, 0.0]
        marker_country = "America"
        features = []  # 如果發生錯誤，設置 features 為空列表
        pie_chart_data = {"labels": [], "data": []}  # 確保 pie_chart_data 有預設值

    # 5.讀取表單 location 欄位
    form_path = os.path.join(folder, "formData.json")
    location = ""
    if os.path.exists(form_path):
        try:
            with open(form_path, "r", encoding="utf-8") as f:
                form_data = json.load(f)
                location = form_data.get("location", "")
        except Exception as e:
            print(f"formData.json parse error: {e}")
            location = ""

    # 6.取得 Complex Heatmap 資料（使用非同步執行並設定超時）
    try:
        pipeline = AntiPipelineComplexHeatmap(actual_job_id)
        # 使用 asyncio.to_thread 將同步的 pipeline.run() 轉為非同步執行
        # 設定超時時間為 60 秒，避免卡住
        try:
            complex_heatmap_result = await asyncio.wait_for(
                asyncio.to_thread(pipeline.run), timeout=60.0
            )
            html_data = complex_heatmap_result.get("html", "")

            # 🔹 確保 complex_heatmap_data 一律為 list
            if isinstance(html_data, str):
                complex_heatmap_data = [html_data]
            elif isinstance(html_data, list):
                complex_heatmap_data = html_data
            else:
                raise ValueError("Unexpected data type for complex heatmap data")
        except asyncio.TimeoutError:
            print(
                f"[Complex Heatmap Error] Timeout after 60 seconds for job_id: {actual_job_id}"
            )
            complex_heatmap_data = []
        except ValueError as ve:
            print(f"[Complex Heatmap Error] Data type issue: {ve}")
            complex_heatmap_data = []
    except Exception as e:
        print(f"[Complex Heatmap Error] General error: {e}")
        import traceback

        traceback.print_exc()
        complex_heatmap_data = []

    # 7.組合所有分析結果並回傳
    return ResultOutputModel(
        job_id=actual_job_id,  # 工作識別碼
        series=series,  # heatmap 資料
        options_ranges=options_ranges,  # heatmap 選項範圍
        gcaCode=gca_code,  # GCA 基因組識別代碼
        genome_file=genome_file,  # 基因組檔案
        taxonomy=taxonomy,  # 系統分類
        query_table=query_table,  # 查詢表格
        hits_table=hits_table,  # 搜尋表格
        hits_hist_1=hist1,  # 搜尋結果直方圖 1
        hits_hist_2=hist2,  # 搜尋結果直方圖 2
        geojson=geojson,  # 地圖 GeoJSON 資料
        marker=marker,  # 地圖標記座標
        location=location,  # 標記位置
        marker_country=marker_country,  # 標記點國家
        pie_chart_data=pie_chart_data,  # 圓餅圖資料
        complex_heatmap_data=complex_heatmap_data,  # Complex Heatmap 資料
    )


# 自動掛載 result_pages 目錄下所有子模組
auto_include_result_pages(router)


# Token 生成 API
class TokenResponseModel(BaseModel):
    token: str
    folder_exists: bool


@router.post("/generate_token_from_job_id", response_model=TokenResponseModel)
async def generate_token_from_job_id(job_id: str = Form(...)) -> TokenResponseModel:
    """
    從 job_id 產生 token。

    目前實現中，token 就是 job_id 本身（向後兼容）。
    如果未來需要更安全的 token 機制，可以在這裡實現簽名或加密。

    Args:
        job_id (str): 工作識別碼

    Returns:
        TokenResponseModel: 包含 token 和 folder_exists 的響應
    """
    # 檢查資料夾是否存在
    folder = os.path.join(BASE_FOLDER, job_id)
    folder_exists = os.path.isdir(folder)

    # 如果資料夾不存在，列出可用的 job IDs 以便除錯
    if not folder_exists:
        available_jobs = []
        if os.path.exists(BASE_FOLDER):
            try:
                available_jobs = [
                    d
                    for d in os.listdir(BASE_FOLDER)
                    if os.path.isdir(os.path.join(BASE_FOLDER, d))
                ]
            except Exception:
                pass

        if available_jobs:
            available_list = "\n".join(available_jobs[:10])  # 最多顯示 10 個
            detail = (
                f"Job ID '{job_id}' not found.\n\nAvailable job IDs:\n{available_list}"
            )
            if len(available_jobs) > 10:
                detail += f"\n... and {len(available_jobs) - 10} more"
        else:
            detail = "No job folders found in the system."

        raise HTTPException(status_code=404, detail=detail)

    # 目前實現：直接使用 job_id 作為 token
    # 如果未來需要更安全的機制，可以在這裡實現簽名或加密
    token = job_id

    return TokenResponseModel(token=token, folder_exists=folder_exists)


# 健康檢查 API
@router.get("/summary")
async def get_summary() -> dict:
    """
    回傳目前已掛載的 result_pages 模組清單
    """
    return {"status": "ok", "modules": [r.path for r in router.routes]}
