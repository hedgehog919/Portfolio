from fastapi import APIRouter, Request
from fastapi.responses import HTMLResponse
from fastapi.templating import Jinja2Templates
from pydantic import BaseModel

# 定義模板目錄
templates = Jinja2Templates(directory="templates")

# 定義路由
router = APIRouter(
    prefix="/myPrefix",
    tags=["myPrefix"],
)


# 定義請求模型
class InputModel(BaseModel):
    input_string: str


# 定義響應模型
class OutputModel(BaseModel):
    output_string: str


@router.post("/hello", response_model=OutputModel)
async def say_hello(data: InputModel) -> OutputModel:
    """接收一個字串，返回字串加上 'Hello, World!!'。

    Args:
    - data (InputModel): 包含輸入字串的請求數據。

    Returns:
    - OutputModel: 返回處理後的字串。
    """
    # 將輸入字串拼接上 "Hello, World!!"
    result = f"{data.input_string} Hello, World!!"
    return OutputModel(output_string=result)


@router.get("/hello_get", response_model=OutputModel)
async def say_hello(input_string: str) -> OutputModel:
    """接收一個字串作為查詢參數，返回字串加上 'Hello, World!!'。

    Args:
    - input_string (str): 請求中的查詢參數。

    Returns:
    - OutputModel: 返回處理後的字串。
    """
    # 將輸入字串拼接上 "Hello, World!!"
    result = f"{input_string} Hello, World!!"
    return OutputModel(output_string=result)


# @router.get("/navbar", response_class=HTMLResponse)
# async def get_navbar(request: Request):
#     """渲染 homeNavbar.html，返回作為響應。

#     Args:
#     - request (Request): FastAPI 的請求對象。
#     Returns:
#     - HTMLResponse: 返回導航列的 HTML。
#     """
#     # 渲染 homeNavbar.html 並返回
#     return templates.TemplateResponse("homeNavbar.html", {"request": request})
