# 使用 Python 3.12 Slim 版本
FROM python:3.12-slim

# 設定工作目錄為 myanti_backend 根目錄
WORKDIR /app/myanti_backend

# 先複製 requirements.txt 以利用 Docker Cache 加速
# 注意：此 Dockerfile 需要從 crossNoso 父目錄構建
COPY myanti_backend/requirements.txt .

# 安裝套件 (包含修復過的 pydantic 和 fastapi-mail)
RUN pip install --no-cache-dir -r requirements.txt

# 複製 myanti_backend 目錄的所有文件到工作目錄
COPY myanti_backend/ .

# 驗證文件結構和 __init__.py 文件存在
RUN ls -la . && \
    test -f __init__.py && \
    test -f main.py && \
    test -f routers/__init__.py && \
    echo "File structure verified successfully"

# 設置 PYTHONPATH 為工作目錄，這樣相對導入才能正常工作
ENV PYTHONPATH=/app/myanti_backend

# 啟動 FastAPI (設定 host 0.0.0.0 讓外部可連線)
# 使用 main:app 因為 main.py 在當前工作目錄中
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "40000"]