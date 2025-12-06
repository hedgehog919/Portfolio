import os
import random
import string
import json
import typing as ty
from datetime import datetime
from pathlib import Path
from fastapi import APIRouter, Form, File, UploadFile, HTTPException, BackgroundTasks
from pydantic import BaseModel, EmailStr
from fastapi.templating import Jinja2Templates
from fastapi_mail import ConnectionConfig, FastMail, MessageSchema
from pipeline.anti_pipeline import run_pipeline
import re
import subprocess
import logging
import asyncio
from concurrent.futures import ThreadPoolExecutor

# =============================
# 1. 路徑與資料夾初始化
# =============================
# 定義專案根目錄與任務資料夾
# 調整 BASE_DIR 取得 myanti_backend 根目錄（向上兩層：routers -> myanti_backend）
BASE_DIR = Path(__file__).resolve().parent.parent
JOBS_ROOT = BASE_DIR / "anti_form_jobs"
JOBS_ROOT.mkdir(parents=True, exist_ok=True)

# =============================
# 2. Jinja2 模板與 FastAPI Router 初始化
# =============================
# 初始化 Jinja2 模板，用於渲染 HTML
submitjob = Jinja2Templates(directory="submitjob")
# 建立 APIRouter，統一管理 /submitjob 路由
router = APIRouter(prefix="/submitjob", tags=["submitjob"])


# =============================
# 3. Pydantic 資料模型
# =============================
# 前端上傳表單模型
class UploadInputModel(BaseModel):
    email: ty.Optional[EmailStr] = None  # 可選 收件者信箱，自動驗證格式
    gcaCode: str  # 必填 GCA Code
    location: ty.Optional[str] = None  # 可選 地點資訊


# 回傳給前端的模型，回傳輸入值與檔案儲存路徑
class UploadOutputModel(BaseModel):
    email: ty.Optional[EmailStr] = None  # 回傳的信箱
    gcaCode: str  # 回傳的 GCA Code
    location: ty.Optional[str] = None  # 回傳的地點
    job_id: str
    file_saved_path: str  # 工作資料夾路徑
    message: str  # 提示使用者如何查詢狀態


# =============================
# 4. 工具函式
# =============================
# 記錄每日流水號計數
serial_counters: ty.Dict[str, int] = {}


# 產生指定長度的隨機字串，含數字與大小寫英文字母
def generate_random_keys(length: int) -> str:
    """
    產生隨機字串

    Args:
        length (int): 欲產生的字串長度

    Returns:
        str: 隨機產生的字串
    """
    pool = string.digits + string.ascii_letters
    return "".join(random.choice(pool) for _ in range(length))


# 產生唯一的工作 ID，格式為 YYYYMMDDss-xxxx-xxxx-xxxxxxxx
def generate_job_id() -> str:
    """
    產生唯一 job_id，並確保資料夾不存在

    Returns:
        str: job_id 字串
    """
    global serial_counters
    today = datetime.now().strftime("%Y%m%d")
    if today not in serial_counters:
        serial_counters[today] = 1
    seq = f"{serial_counters[today]:02d}"
    serial_counters[today] += 1

    job_id = (
        f"{today}{seq}-"
        f"{generate_random_keys(4)}-"
        f"{generate_random_keys(4)}-"
        f"{generate_random_keys(8)}"
    )
    folder = os.path.join("anti_form_jobs", job_id)
    if not os.path.exists(folder):
        return job_id
    # 若已存在，遞迴產生新的
    return generate_job_id()


# GCA code 格式驗證
GCACODE_PATTERN = r"^GC[AF]_[0-9]{9}(\.\d)?$"


def validate_gca_code(gca_code: str) -> bool:
    """
    驗證 GCA code 格式是否正確

    Args:
        gca_code (str): 使用者輸入的 GCA code

    Returns:
        bool: 是否符合格式
    """
    return re.match(GCACODE_PATTERN, gca_code) is not None


# 執行 perl 腳本下載基因體序列
def download_genome_seq(gca_code: str, output_folder: str):
    """
    執行 perl 腳本下載基因體序列

    Args:
        gca_code (str): GCA code
        output_folder (str): 輸出資料夾

    Returns:
        str: 執行結果標準輸出

    Raises:
        RuntimeError: 若下載失敗
    """
    script_path = "/home/chieh/antibiogram_platform/bin/0.Download-GenomeSeq.pl"
    try:
        result = subprocess.run(
            ["perl", script_path, "-i", gca_code, "-o", output_folder],
            check=True,
            capture_output=True,
            text=True,
        )
        return result.stdout
    except subprocess.CalledProcessError as e:
        raise RuntimeError(f"Genome download failed: {e.stderr}")


# 非同步寄信函式，使用 FastAPI-Mail 套件
async def send_email(subject: str, recipients: ty.List[str], body: str) -> None:
    """
    設定並發送電子郵件

    Args:
        subject (str): 郵件主旨
        recipients (List[str]): 收件者清單
        body (str): HTML 或純文字格式的郵件內容

    Returns:
        None
    """
    conf = ConnectionConfig(
        MAIL_USERNAME="m138030014@g-mail.nsysu.edu.tw",
        MAIL_PASSWORD="gvqeayraxmtjmrqq",
        MAIL_SERVER="smtp.gmail.com",
        MAIL_PORT=587,
        # ----------------------------------------------------
        # MAIL_STARTTLS: 是否使用 STARTTLS 升級到安全連線
        # MAIL_SSL_TLS: 是否使用 SSL/TLS 直接連接到郵件伺服器
        # ----------------------------------------------------
        MAIL_STARTTLS=True,  # 使用 STARTTLS
        MAIL_SSL_TLS=False,  # 禁用 SSL/TLS 直接連接
        # MAIL_DEBUG=2,
        MAIL_FROM="m138030014@g-mail.nsysu.edu.tw",
        MAIL_FROM_NAME="crossNoso Server",
        USE_CREDENTIALS=True,  # (可省略，預設 True)
        VALIDATE_CERTS=True,  # (可省略，預設 True)
        # TIMEOUT=60,  # 可依需求調整逾時秒數
    )
    message = MessageSchema(
        subject=subject, recipients=recipients, body=body, subtype="html"
    )
    fm = FastMail(conf)
    await fm.send_message(message)


# =============================
# 5. 上傳與分析 API
# =============================
# /upload：處理表單與檔案上傳、資料儲存、pipeline 執行、寄送通知信
@router.post("/upload", response_model=UploadOutputModel)
async def upload_file(
    email: ty.Optional[EmailStr] = Form(None),
    gcaCode: str = Form(...),
    location: ty.Optional[str] = Form(None),
    country: str = Form("-1"),  # 新增 country 欄位，預設 -1（未選）
    file: UploadFile = File(None),
    # 新增 request 參數以便取得 router
    request=None,
) -> UploadOutputModel:
    """
    上傳表單與檔案，並啟動後端分析流程。
    1. 產生 job_id 並建立資料夾
    2. 儲存表單資料與檔案（或自動下載）
    3. 執行 pipeline
    4. 若有填 email 則寄送通知信
    5. 回傳 job_id 與狀態查詢提示
    """
    # step1：產生 job_id 並建立資料夾
    job_id = generate_job_id()
    folder = os.path.join("anti_form_jobs", job_id)
    os.makedirs(folder, exist_ok=True)

    # 驗證 gcacode 格式
    if gcaCode and not validate_gca_code(gcaCode):
        raise HTTPException(status_code=400, detail="Invalid GCA Code format.")

    # step2：將表單資料存成 JSON
    # gcaCode 儲存為手填值，若沒填則用檔案名稱
    gca_value = gcaCode if gcaCode.strip() else (file.filename if file else "")
    data = {
        "email": email or "",
        "gcaCode": gca_value,
        "location": location or "",
        "country": country,
    }
    json_path = os.path.join(folder, "formData.json")
    with open(json_path, "w", encoding="utf-8") as fp:
        json.dump(data, fp, ensure_ascii=False, indent=4)

    # step3：處理上傳的 FASTA；若沒上傳，則自動下載
    fasta_path = os.path.join(folder, "contigFile.fa")
    if file:
        try:
            contents = await file.read()
            with open(fasta_path, "wb") as fp:
                fp.write(contents)
        except Exception as e:
            raise HTTPException(
                status_code=500, detail=f"Fasta saving failed: {str(e)}"
            )
    else:
        # 沒有上傳檔案時，呼叫 perl 腳本下載
        try:
            download_genome_seq(gcaCode, folder)
        except Exception as e:
            raise HTTPException(
                status_code=500, detail=f"Genome download failed: {str(e)}"
            )

    # step4：將分析任務丟進 queue，由 worker pool 處理
    # 使用 router 上的 queue
    await router.analysis_queue.put(folder)

    # step5：寄送通知信（如有填 email）
    # 伺服器 url
    # f'<a href="http://140.117.103.223:8080/sampleoutput?folder={job_id}">'
    # f"http://140.117.103.223:8080/sampleoutput?folder={job_id}</a><br><br>"
    # 本地 url
    # f'<a href="http://localhost:35791/sampleoutput?folder={job_id}">'
    # f"http://localhost:35791 /sampleoutput?folder={job_id}</a><br><br>"

    if email:
        subject = f"crossNoso: Your job {job_id} is submitted."
        body = (
            f"Dear User,<br><br>"
            f"Your job ID is <b>{job_id}</b>.<br>"
            f"You can check the status via:<br>"
            f'<a href="http://localhost:8080/sampleoutput?folder={job_id}">'
            f"http://localhost:8080/sampleoutput?folder={job_id}</a><br><br>"
            f"Once finished, you will receive another email with results link.<br><br>"
            f"Thanks,<br>crossNoso Server"
        )
        try:
            await send_email(subject, [email], body)
        except Exception as e:
            raise HTTPException(
                status_code=502, detail=f"Email sending failed: {str(e)}"
            )

    # step6：立即回傳 job_id，提示查詢方式
    return UploadOutputModel(
        email=email,
        gcaCode=gcaCode,
        location=location,
        job_id=job_id,
        file_saved_path=folder,
        message=f"Your job {job_id} has been submitted. Please check status later.",
    )


# =============================
# 佇列 + worker pool  :
# 本區塊負責分析任務的非同步排程與執行。
# 1. ANALYSIS_QUEUE 會在啟動事件中建立，負責儲存待分析的資料夾路徑。
# 2. analysis_worker() 是 worker 協程，會從 queue 取出任務並用 ThreadPoolExecutor 執行 run_pipeline。
# 3. 若分析成功會在資料夾下建立 complete_ok 檔案，失敗則寫入 pipeline_error.log。
# 4. 啟動時會建立多個 worker（ANALYSIS_WORKER_COUNT），確保可同時處理多個任務。
# =============================
ANALYSIS_WORKER_COUNT = 5


# analysis_worker 現在會接收 router 參數，方便取得 queue/executor
async def analysis_worker(router):
    loop = asyncio.get_event_loop()
    while True:
        folder = await router.analysis_queue.get()
        try:
            # 用 ThreadPoolExecutor 執行 run_pipeline，確保多執行緒同時分析
            await loop.run_in_executor(router.analysis_executor, run_pipeline, folder)
            open(os.path.join(folder, "complete_ok"), "w").close()
        except Exception as e:
            err_path = os.path.join(folder, "pipeline_error.log")
            with open(err_path, "w", encoding="utf-8") as ef:
                ef.write(str(e))
        finally:
            router.analysis_queue.task_done()


# 啟動 worker pool（FastAPI 啟動時）
@router.on_event("startup")
async def start_analysis_workers():
    # 在正確的事件迴圈中建立 queue 和 executor
    router.analysis_queue = asyncio.Queue()
    router.analysis_executor = ThreadPoolExecutor(max_workers=ANALYSIS_WORKER_COUNT)
    for _ in range(ANALYSIS_WORKER_COUNT):
        asyncio.create_task(analysis_worker(router))


# =============================
# 6. 狀態查詢 API
# =============================
# /status/{job_id}：查詢任務是否完成
@router.get("/status/{job_id}")
async def check_status(job_id: str) -> ty.Dict[str, str]:
    """
    查詢指定 job_id 的任務狀態。
    - 若 complete_ok 存在則回傳 done
    - 否則回傳 running
    """
    folder = os.path.join("anti_form_jobs", job_id)
    if not os.path.isdir(folder):
        raise HTTPException(status_code=404, detail="Job ID not found.")
    if os.path.exists(os.path.join(folder, "complete_ok")):
        # 任務已完成，回傳狀態與 job_id
        return {"status": "done", "job_id": job_id}
    # 任務尚未完成，回傳 running 狀態
    else:
        return {"status": "running", "job_id": job_id}


# =============================
# 7. 結果查詢 API
# =============================
# /result/{job_id}：取得任務完成後的結果檔案列表
@router.get("/result/{job_id}")
async def get_result(job_id: str) -> ty.Dict[str, ty.Any]:
    """
    取得指定 job_id 的所有結果檔案清單。
    若尚未完成，回傳 400 錯誤。
    """
    # 檢查資料夾是否存在，並確認任務是否完成
    folder = os.path.join("anti_form_jobs", job_id)
    if not os.path.isdir(folder):
        raise HTTPException(status_code=404, detail="Job ID not found.")

    # 檢查資料夾下是否有 complete_ok
    if not os.path.exists(os.path.join(folder, "complete_ok")):
        raise HTTPException(
            status_code=402, detail="job not completed yet. Please wait."
        )

    # 列出 folder 底下所有副檔名為 .tsv/.png/.pdf/.out/.html 等檔案
    all_files = []
    for root, _, files in os.walk(folder):
        for fname in files:
            if fname.endswith((".tsv", ".png", ".pdf", ".out", ".html")):
                rel_path = os.path.relpath(os.path.join(root, fname), folder)
                all_files.append(rel_path)
    return {"job_id": job_id, "files": all_files}


# =============================
# 8. 檔案下載 API
# =============================
# /download/{job_id}/{filename}：下載指定任務的檔案
@router.get("/download/{job_id}/{filename}")
async def download_file(job_id: str, filename: str):
    """
    下載指定 job_id 目錄下的檔案。
    若檔案不存在則回傳 404。
    """
    folder = os.path.join("anti_form_jobs", job_id)
    if not os.path.isdir(folder):
        raise HTTPException(status_code=404, detail="Job ID not found.")
    file_path = os.path.join(folder, filename)
    if not os.path.exists(file_path):
        raise HTTPException(status_code=404, detail="File not found.")
    from fastapi.responses import FileResponse

    return FileResponse(path=file_path, filename=filename)
