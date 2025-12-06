import random
from fastapi import APIRouter, Form, HTTPException
from fastapi.templating import Jinja2Templates
from pydantic import BaseModel
from typing import List, Any

# 指定模板目錄（用於 HTML 渲染需求），此處目錄為 "result"
result = Jinja2Templates(directory="result")

# 建立路由器，所有此路由下的 API 路徑均會自動加上 /result
router = APIRouter(
    prefix="/result",
    tags=["result"],
)

# ---------------------------
# 定義資料模型
# ---------------------------


# 請求模型：目前僅包含 job_id，作為資料定位依據
class ResultInputModel(BaseModel):
    job_id: str


# 回傳模型：包含圖表數據系列、色階範圍、檔案名稱與菌種分類資訊
class ResultOutputModel(BaseModel):
    series: List[Any]
    options_ranges: List[Any]
    genome_file: str
    taxonomy: str


# ---------------------------
# 資料生成相關函式
# ---------------------------


def generate_data(count: int, yrange: dict):
    """
    根據指定筆數與數值範圍生成一組數據。

    參數:
        count (int): 生成數據的筆數。
        yrange (dict): 數值範圍，必須包含 "min" 與 "max" 兩個鍵值。

    回傳:
        List[dict]: 每筆數據格式為 { "x": str, "y": int }。
    """
    data = []
    for i in range(count):
        x = str(i + 1)  # x 軸數值以字串呈現
        y = random.randint(yrange["min"], yrange["max"])  # y 值隨機生成
        data.append({"x": x, "y": y})
    return data


def generate_chart_data() -> (List[Any], List[Any]):
    """
    動態生成圖表資料與色階範圍設定，主要用於 heatmap 圖表。

    回傳:
        Tuple[List[Any], List[Any]]:
            - 第一個元素 series：包含各月份數據的列表。
            - 第二個元素 options_ranges：色階範圍設定列表。
    """
    # 生成每個月的圖表數據，這裡每個月產生 20 筆數據，數值範圍設定為 -30 至 55
    series = [
        {"name": "Jan", "data": generate_data(20, {"min": -30, "max": 55})},
        {"name": "Feb", "data": generate_data(20, {"min": -30, "max": 55})},
        {"name": "Mar", "data": generate_data(20, {"min": -30, "max": 55})},
        {"name": "Apr", "data": generate_data(20, {"min": -30, "max": 55})},
        {"name": "May", "data": generate_data(20, {"min": -30, "max": 55})},
        {"name": "Jun", "data": generate_data(20, {"min": -30, "max": 55})},
        {"name": "Jul", "data": generate_data(20, {"min": -30, "max": 55})},
        {"name": "Aug", "data": generate_data(20, {"min": -30, "max": 55})},
        {"name": "Sep", "data": generate_data(20, {"min": -30, "max": 55})},
    ]

    # 定義 heatmap 圖表的配置，其中 colorScale.ranges 用於色階設定
    chart_options = {
        "chart": {"height": 350, "type": "heatmap"},
        "plotOptions": {
            "heatmap": {
                "shadeIntensity": 0.5,
                "radius": 0,
                "useFillColorAsStroke": True,
                "colorScale": {
                    "ranges": [
                        {"from": -30, "to": 5, "name": "low", "color": "#00A100"},
                        {"from": 6, "to": 20, "name": "medium", "color": "#128FD9"},
                        {"from": 21, "to": 45, "name": "high", "color": "#FFB200"},
                        {"from": 46, "to": 55, "name": "extreme", "color": "#FF0000"},
                    ]
                },
            }
        },
        "dataLabels": {"enabled": False},
        "stroke": {"width": 1},
        "title": {"text": "Complex Heatmap"},
    }
    # 從圖表配置中提取色階範圍設定
    options_ranges = chart_options["plotOptions"]["heatmap"]["colorScale"]["ranges"]

    return series, options_ranges


# ---------------------------
# API 路由處理
# ---------------------------


@router.post("/result", response_model=ResultOutputModel)
async def get_result(job_id: str = Form(...)) -> ResultOutputModel:
    """
    根據前端傳入的 job_id 生成並回傳圖表數據與色階設定，
    同時模擬回傳 genome_file 與 taxonomy 資訊。

    參數:
        job_id (str): 從前端表單傳入的工作識別碼，用以定位對應的資料夾。

    回傳:
        ResultOutputModel: 包含 series、options_ranges、genome_file 與 taxonomy 的 JSON 物件。
    """
    try:
        # 動態生成圖表數據與色階範圍
        generated_series, generated_options_ranges = generate_chart_data()

        # 模擬取得檔案與菌種資訊
        genome_file = "GCA_002762095.1"  # 模擬回傳檔案名稱，可改為讀取真實檔案
        taxonomy = "Acinetobacter baumannii"  # 模擬回傳菌種分類

        # 建立回傳的模型
        output = ResultOutputModel(
            series=generated_series,
            options_ranges=generated_options_ranges,
            genome_file=genome_file,
            taxonomy=taxonomy,
        )
        return output
    except Exception as e:
        print(f"處理過程發生錯誤：{str(e)}")
        raise HTTPException(status_code=500, detail="Internal Server Error")
