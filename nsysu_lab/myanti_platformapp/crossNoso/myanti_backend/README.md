# MyAnti PlatformApp - 後端專案

## 專案結構

專案目錄如下：

```
backend/                         # 專案根目錄
├─ __pycache__/                  # ⚙️ Python 編譯快取
├─ analysis/                     # 🔍 分析與實驗腳本
│   └─ 1.Taxonomic-Assignments.py  # 🧬 分類指派分析腳本
├─ anti_form_jobs/               # 🤖 anti_form 任務處理模組
├─ routers/                      # 🌐 API 路由定義
│   ├─ __pycache__/              # ⚙️ Python 編譯快取
│   ├─ old_template/             # 📂 舊版 API 模板
│   ├─ api_anitform.py           # 📨 anti_form API 處理
│   ├─ api_result.py             # 📊 結果回傳 API
│   └─ api_search.py             # 🔎 查詢 API
├─ .gitignore                    # 🚫 Git 忽略規則
├─ config.py                     # ⚙️ 全域設定（環境變數、常數）
├─ main.py                       # 🚀 後端服務啟動入口
├─ README.md                     # 📝 專案說明文件
└─ requirements.txt              # 📦 Python 套件依賴清單


```

## 目錄與文件說明

- **`configs/`**：存放應用程式的設定檔。
- **`library/`**：包含工具函數與自訂函式庫。
- **`models/`**：定義資料模型與邏輯。
- **`routers/`**：管理 API 路由。
- **`schemas/`**：定義 Pydantic 模型，進行請求驗證。
- **`main.py`**：FastAPI 應用程式的主入口點。

## 使用方式

### 1. 安裝依賴套件
請先安裝必要的套件：
```bash
cd backend
pip install -r requirements.txt
```

### 2. 設置虛擬環境
啟動虛擬環境：
```bash
./venv/Scripts/activate  # Windows
source venv/bin/activate  # macOS/Linux
## ERROR : Badly placed ()'s. => 初始 shell 是 csh 或 tcsh，非以上兩者需切換 shell
```

### 3. 啟動應用程式
執行 FastAPI 應用程式：
```bash
python main.py
```

### 4. 訪問 API 文件
```web
http://127.0.0.1:8000/docs
```

## 聯絡我們
若有任何問題或建議，請聯絡我們：
**sunny45221@gmail.com**