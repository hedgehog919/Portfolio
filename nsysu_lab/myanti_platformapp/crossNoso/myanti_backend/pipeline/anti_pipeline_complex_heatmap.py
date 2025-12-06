# -*- coding: utf-8 -*-
"""
anti_pipeline_complex_heatmap.py
------------------------------------------------------------
抗藥性熱圖分析流程 (Pipeline 層)
------------------------------------------------------------

本模組提供抗藥性熱圖的完整分析流程，包含：
1. 資料載入與預處理：讀取抗藥性資料、物種資訊、地理資訊等
2. 資料標準化：進行 one-hot encoding（物種、地理、年份）
3. 熱圖生成：支援兩種模式
   - 標註熱圖：包含物種、地理、年份等多維度標註
   - 混合熱圖：簡化版熱圖，專注於抗藥性模式
4. 互動式視覺化：生成 HTML 互動式熱圖，支援縮放、拖曳、匯出等功能
5. 靜態圖表匯出：支援 PDF、PNG、JPG 格式匯出（需 Kaleido）

主要類別：
    AntiPipelineComplexHeatmap: 抗藥性熱圖分析流程主類別
"""

import os
import typing as ty
import pandas as pd
import scipy.cluster.hierarchy as sch
import plotly.graph_objects as go
from plotly.subplots import make_subplots
import plotly.figure_factory as ff
from PIL import Image
import io
import base64
from typing import Dict, Tuple

try:
    import kaleido  # noqa: F401

    KALEIDO_AVAILABLE = True
    KALEIDO_IMPORT_ERROR = None
except Exception as _kaleido_error:  # pragma: no cover - 只在缺少 Kaleido 時觸發
    KALEIDO_AVAILABLE = False
    KALEIDO_IMPORT_ERROR = _kaleido_error


class AntiPipelineComplexHeatmap:
    """抗藥性熱圖分析流程主類別"""

    # ========================================================================
    # 常數配置：集中管理所有靜態配置資料
    #
    # 【物種相關】
    #   - SPECIES_ABBR: 物種全名 → 縮寫對應（5 種物種）
    #   - SPECIES_LABELS: 縮寫 → 顯示標籤對應
    #
    # 【地理相關】
    #   - LOCATION_TO_REGION: 國家/地區 → 大洲對應
    #   - REGIONS: 大洲列表（8 個大洲）
    #
    # 【視覺化相關】
    #   - CLASS_COLORS: 抗生素類別 ID → 顏色對應（24 種類別）
    # ========================================================================
    # 物種縮寫
    SPECIES_ABBR = {
        "Acinetobacter baumannii": "AB",
        "Enterococcus faecium": "EF",
        "Klebsiella pneumoniae": "KP",
        "Pseudomonas aeruginosa": "PA",
        "Staphylococcus aureus": "SA",
    }

    # 物種全名
    SPECIES_LABELS = {
        "AB": "A. baumannii",
        "EF": "E. faecium",
        "KP": "K. pneumoniae",
        "PA": "P. aeruginosa",
        "SA": "S. aureus",
    }

    # 地理區域轉換為大洲對應
    LOCATION_TO_REGION = {
        "Taiwan": "Asia",
        "China": "Asia",
        "Japan": "Asia",
        "India": "Asia",
        "Thailand": "Asia",
        "Vietnam": "Asia",
        "South_Korea": "Asia",
        "Singapore": "Asia",
        "Philippines": "Asia",
        "Indonesia": "Asia",
        "Malaysia": "Asia",
        "Bangladesh": "Asia",
        "Pakistan": "Asia",
        "Israel": "Middle_East",
        "Saudi_Arabia": "Middle_East",
        "UAE": "Middle_East",
        "Iran": "Middle_East",
        "Turkey": "Middle_East",
        "Lebanon": "Middle_East",
        "France": "Europe",
        "Germany": "Europe",
        "UK": "Europe",
        "Italy": "Europe",
        "Spain": "Europe",
        "Netherlands": "Europe",
        "Belgium": "Europe",
        "Switzerland": "Europe",
        "Austria": "Europe",
        "Poland": "Europe",
        "Sweden": "Europe",
        "Norway": "Europe",
        "Denmark": "Europe",
        "Egypt": "Africa",
        "South_Africa": "Africa",
        "Nigeria": "Africa",
        "Kenya": "Africa",
        "Algeria": "Africa",
        "Morocco": "Africa",
        "USA": "North_America",
        "Canada": "North_America",
        "Mexico": "North_America",
        "Brazil": "South_America",
        "Argentina": "South_America",
        "Chile": "South_America",
        "Colombia": "South_America",
        "Peru": "South_America",
        "Venezuela": "South_America",
        "Australia": "Australia",
        "New_Zealand": "Australia",
        "Fiji": "Oceania",
        "Papua_New_Guinea": "Oceania",
    }

    # 大洲列表
    REGIONS = [
        "Asia",
        "Middle_East",
        "Europe",
        "Africa",
        "North_America",
        "South_America",
        "Australia",
        "Oceania",
    ]

    # 抗生素類別顏色
    CLASS_COLORS = {
        1: "rgba(227, 144, 140, 0.6)",
        2: "rgba(255, 165, 0, 0.6)",
        3: "rgba(92, 192, 255, 0.6)",
        4: "rgba(1, 117, 128, 0.6)",
        5: "rgba(201, 154, 224, 0.6)",
        6: "rgba(255, 108, 92, 0.6)",
        7: "rgba(65, 95, 148, 0.6)",
        8: "rgba(97, 231, 134, 0.6)",
        9: "rgba(224, 198, 99, 0.6)",
        10: "rgba(224, 68, 68, 0.6)",
        11: "rgba(82, 156, 224, 0.6)",
        12: "rgba(224, 114, 29, 0.6)",
        13: "rgba(132, 53, 148, 0.6)",
        14: "rgba(224, 123, 104, 0.6)",
        15: "rgba(39, 75, 148, 0.6)",
        16: "rgba(140, 224, 102, 0.6)",
        17: "rgba(148, 78, 47, 0.6)",
        18: "rgba(247, 89, 207, 0.6)",
        19: "rgba(101, 228, 228, 0.6)",
        20: "rgba(203, 0, 0, 0.6)",
        21: "rgba(22, 39, 219, 0.6)",
        22: "rgba(153, 148, 222, 0.6)",
        23: "rgba(143, 121, 6, 0.6)",
        24: "rgba(128, 128, 128, 0.6)",
    }

    def __init__(self, job_id: str) -> None:
        """初始化分析流程"""
        backend_root = os.path.dirname(os.path.dirname(__file__))
        self.sub_folder = os.path.join(backend_root, "anti_form_jobs", job_id)
        self.out_path = os.path.join(self.sub_folder, "7.complexheatmap")
        os.makedirs(self.out_path, exist_ok=True)
        self.profile_columns: ty.List[str] = []

    # ========================================================================
    # 資料處理：載入、預處理、合併與摘要輸出
    #
    # 【資料載入】
    #   - load_data: 讀取抗藥性資料、樣本資訊、物種分類、國家資訊
    #   - _empty_data_dict: 返回空資料字典（錯誤處理用）
    #
    # 【資料預處理】
    #   - preprocess_table: 選取欄位、加入 Query 樣本、執行 one-hot encoding
    #     （物種、地理區域、年份轉換為數值欄位）
    #
    # 【資料合併】
    #   - merge_data: 合併抗藥性資料與樣本元資料，建立完整 DataFrame
    #
    # 【摘要輸出】
    #   - generate_summary: 計算平均抗藥性，輸出摘要統計 TSV 檔案
    # ========================================================================
    def load_data(self) -> ty.Dict[str, pd.DataFrame]:
        """讀取必要輸入資料"""
        # 抗藥性資料路徑
        hits_profile_path = os.path.join(
            self.sub_folder, "3.abProfilesCmp", "hits_profile.tsv"
        )
        # 抗藥性資料路徑
        hits_table_path = os.path.join(
            self.sub_folder, "3.abProfilesCmp", "hits_table.tsv"
        )
        # 分類資料路徑
        tax_result_path = os.path.join(
            self.sub_folder, "1.taxAssign", "taxAssign.result"
        )
        # 表單資料路徑
        formdata_path = os.path.join(self.sub_folder, "formData.json")

        # 檢查檔案存在性
        for path in [hits_profile_path, hits_table_path, tax_result_path]:
            if not os.path.exists(path):
                print(f"[警告] 找不到必要檔案：{path}")
                return self._empty_data_dict()

        # 讀取資料
        hits_profile = pd.read_csv(hits_profile_path, sep="\t")
        hits_table = pd.read_csv(hits_table_path, sep="\t")
        query_species = pd.read_csv(tax_result_path, sep="\t", header=None)

        # 讀取國家資訊
        import json

        country_value = "Unknown"
        if os.path.exists(formdata_path):
            with open(formdata_path, "r", encoding="utf-8") as f:
                formdata = json.load(f)
            country_value = formdata.get("country", "Unknown")
        query_country = pd.DataFrame([[country_value]])

        return {
            "profile": hits_profile,
            "table": hits_table,
            "species": query_species,
            "country": query_country,
        }

    def _empty_data_dict(self) -> ty.Dict[str, pd.DataFrame]:
        """返回空的資料字典"""
        return {
            "profile": pd.DataFrame(),
            "table": pd.DataFrame(),
            "species": pd.DataFrame(),
            "country": pd.DataFrame(),
        }

    # ========================================================================
    # 資料預處理與 one-hot encoding
    #
    # 【One-hot Encoding 說明】
    #   將分類資料（物種、地區、年份等文字/類別）轉換為數值欄位：
    #   - 為每個類別建立一個欄位（0 或 1）
    #   - 資料屬於該類別時填 1，否則填 0
    #   - 目的：將文字資料轉換為可計算的數值格式
    # ========================================================================
    def preprocess_table(
        self,
        table: pd.DataFrame,
        query_species: pd.DataFrame,
        query_country: pd.DataFrame,
    ) -> pd.DataFrame:
        """預處理樣本資料表

        執行以下處理：
        - 選取並重新命名必要欄位
        - 加入 Query 樣本資訊
        - 進行物種、地理、年份的 one-hot encoding

        Args:
            table: 原始樣本資料表
            query_species: Query 樣本的物種資訊
            query_country: Query 樣本的國家資訊

        Returns:
            pd.DataFrame: 預處理後的資料表
        """
        # 檢查資料是否為空
        if table.empty:
            return pd.DataFrame()

        # 選取並重新命名欄位
        table = table.iloc[:, [1, 2, 4, 5]]
        table.columns = ["Genome_ID", "Species", "Date", "Location"]

        # 加入 Query 樣本
        query_row = pd.DataFrame(
            [
                {
                    "Genome_ID": "Query",
                    "Species": (  # 物種為空
                        query_species.iloc[0, 0].replace("_", " ")
                        if not query_species.empty
                        else "Unknown"
                    ),
                    "Date": "-",  # 日期為空
                    "Location": (  # 國家為空
                        query_country.iloc[0, 0]
                        if not query_country.empty
                        else "Unknown"
                    ),
                }
            ]
        )
        table = pd.concat(
            [query_row, table], ignore_index=True
        )  # 合併查詢樣本資訊與表格資料

        table["Abbr"] = table["Species"].map(self.SPECIES_ABBR)  # 將物種轉換為縮寫
        for abbr in ["AB", "EF", "KP", "PA", "SA"]:
            table[abbr] = (table["Abbr"] == abbr).astype(int)

        table["Country"] = (  # 將地理區域轉換為大洲對應
            table["Location"].map(self.LOCATION_TO_REGION).fillna("Other")
        )
        for region in self.REGIONS:  # 將大洲轉換為 one-hot encoding
            table[region] = (table["Country"] == region).astype(int)

        table["Year"] = table["Date"].apply(  # 將年份轉換為數值欄位
            lambda x: (
                int(str(x)[:4]) if isinstance(x, str) and str(x)[:4].isdigit() else 0
            )
        )
        for year in range(2000, 2022):  # 將年份轉換為 one-hot encoding
            table[str(year)] = (table["Year"] == year).astype(int)

        table["Region"] = table["Country"]
        return table

    # ========================================================================
    # 資料合併：合併抗藥性資料與樣本元資料
    #
    # 【資料合併】
    #   - merge_data: 合併抗藥性資料與樣本元資料，建立完整 DataFrame
    # ========================================================================
    def merge_data(self, profile: pd.DataFrame, table: pd.DataFrame) -> pd.DataFrame:
        """合併抗藥性資料與樣本元資料

        Args:
            profile: 抗藥性資料表
            table: 樣本元資料表（包含物種、地理、年份等）

        Returns:
            pd.DataFrame: 合併後的資料表，若輸入為空則返回空 DataFrame
        """
        if profile.empty or table.empty:
            return pd.DataFrame()
        merged = profile.merge(table, on="Genome_ID", how="left")
        merged = merged.set_index("Genome_ID").loc[profile["Genome_ID"]].reset_index()
        return merged

    # ========================================================================
    # 【全域方法】摘要輸出：生成摘要統計 TSV 檔案
    #
    # generate_summary: 生成摘要統計 TSV 檔案（寫入磁碟）
    #   - 用途：生成獨立的 TSV 檔案供用戶下載或查看
    #   - 處理流程：選取抗藥性欄位 → 計算平均值 → 輸出摘要統計欄位 → 寫入檔案
    #   - 返回：檔案路徑（str）
    #   - 檔案位置：{out_path}/heatmap_summary.tsv
    #   - 調用位置：run() 方法中
    # ========================================================================
    def generate_summary(self, df: pd.DataFrame) -> str:
        """生成摘要統計檔案

        計算各樣本的平均抗藥性，並輸出包含樣本 ID、物種、地理、
        年份和平均抗藥性的 TSV 檔案。

        Args:
            df: 合併後的抗藥性資料表

        Returns:
            str: 摘要統計檔案路徑，若資料為空或無抗藥性欄位則返回空字串
        """
        if df.empty or not self.profile_columns:
            return ""

        resistance_cols = [
            col for col in self.profile_columns if col in df.columns
        ]  # 選取抗藥性欄位
        if not resistance_cols:
            return ""

        df = df.copy()  # 複製合併後的抗藥性資料表
        df["Mean_Resistance"] = df[resistance_cols].mean(axis=1)  # 計算抗藥性平均值
        summary_columns = [  # 選取摘要統計欄位
            col
            for col in [
                "Genome_ID",  # 樣本 ID
                "Species",  # 物種
                "Location",  # 地理區域
                "Region",  # 大洲
                "Year",  # 年份
                "Mean_Resistance",  # 抗藥性平均值
            ]
            if col in df.columns  # 如果欄位在合併後的抗藥性資料表中，則選取
        ]

        summary_path = os.path.join(  # 摘要統計檔案路徑
            self.out_path, "heatmap_summary.tsv"
        )
        df[summary_columns].to_csv(  # 將摘要統計資料寫入檔案
            summary_path, sep="\t", index=False
        )
        print(f"✅ Summary 已輸出：{summary_path}")  # 輸出摘要統計檔案路徑
        return summary_path  # 返回摘要統計檔案路徑

    # ========================================================================
    # 【內部方法】TSV 摘要生成：生成 TSV 格式摘要內容（字串格式）
    #
    # _generate_tsv_content: 生成 TSV 格式摘要內容（字串格式）
    #   - 用途：將 TSV 內容嵌入到 HTML 的 JavaScript 中，供前端互動功能使用
    #   - 處理流程：選取抗藥性欄位 → 計算平均值 → 輸出摘要統計欄位 → 返回字串
    #   - 返回：TSV 內容字串（str）
    #   - 調用位置：plot_heatmap_with_annotations() 和 plot_heatmap_hybrid() 中
    #   - 錯誤處理：包含 try-except 錯誤處理機制
    # ========================================================================
    def _generate_tsv_content(self, df: pd.DataFrame) -> str:
        """生成 TSV 摘要內容（字串格式）

        內部方法，用於生成 TSV 格式的摘要內容字串，而非直接寫入檔案。

        Args:
            df: 合併後的抗藥性資料表

        Returns:
            str: TSV 格式的摘要內容字串，若資料為空則返回空字串
        """
        try:
            if df.empty or not self.profile_columns:
                return ""
            resistance_cols = [col for col in self.profile_columns if col in df.columns]
            if not resistance_cols:
                return ""

            df_tsv = df.copy()
            df_tsv["Mean_Resistance"] = df_tsv[resistance_cols].mean(
                axis=1
            )  # 計算抗藥性平均值
            summary_columns = [
                col
                for col in [
                    "Genome_ID",
                    "Species",
                    "Location",
                    "Region",
                    "Year",
                    "Mean_Resistance",
                ]
                if col in df_tsv.columns
            ]

            from io import StringIO  # 字串緩衝區

            tsv_buffer = StringIO()  # 建立字串緩衝區
            df_tsv[summary_columns].to_csv(
                tsv_buffer, sep="\t", index=False
            )  # 將摘要統計資料寫入字串緩衝區
            return tsv_buffer.getvalue()  # 返回字串緩衝區的值
        except Exception as e:
            print(f"⚠️ 生成 TSV 摘要時發生錯誤：{e}")
            return ""

    # ========================================================================
    # 【重點說明】generate_summary 與 _generate_tsv_content 的差異
    #
    # 相同點：
    #   - 都處理相同的資料（合併後的抗藥性資料表）
    #   - 都執行相同的計算邏輯（選取抗藥性欄位、計算平均值、選取摘要統計欄位）
    #
    # 差異點：
    #   1. 可見性：generate_summary 為全域方法，_generate_tsv_content 為內部方法
    #   2. 輸出方式：generate_summary 寫入檔案，_generate_tsv_content 返回字串
    #   3. 返回內容：generate_summary 返回檔案路徑，_generate_tsv_content 返回 TSV 內容字串
    #   4. 使用場景：generate_summary 用於生成獨立檔案，_generate_tsv_content 用於嵌入 HTML
    #   5. 錯誤處理：generate_summary 無錯誤處理，_generate_tsv_content 有 try-except
    #   6. 調用位置：generate_summary 在 run() 中調用，_generate_tsv_content 在繪圖方法中調用
    # ========================================================================

    # ========================================================================
    # 靜態圖像匯出與 Plotly 配置：封裝輔助功能，讓主要繪圖流程聚焦在視覺化本身
    #
    # 【靜態圖像匯出】
    #   - _export_static_images: 匯出 PDF/JPG 格式（需安裝 Kaleido）
    #     刪除舊檔案 → 檢查 Kaleido → 匯出 PDF 和 JPG
    #
    # 【Plotly 配置】
    #   - _get_plotly_config: 返回自訂工具列配置
    #     包含縮放控制、按鈕設定等
    # ========================================================================
    def _export_static_images(
        self, fig: go.Figure, width: int = None, height: int = None
    ) -> Tuple[str, str]:
        """匯出靜態圖像（PDF/JPG）

        將 Plotly 圖形匯出為 PDF 和 JPG 格式。需要安裝 Kaleido。

        Args:
            fig: Plotly 圖形物件
            width: 圖像寬度（像素），None 時使用圖形預設值
            height: 圖像高度（像素），None 時使用圖形預設值

        Returns:
            Tuple[str, str]: (PDF 路徑, JPG 路徑)，若匯出失敗則返回空字串
        """
        pdf_path = os.path.join(self.out_path, "ComplexHeatmap.pdf")  # PDF 檔案路徑
        jpg_path = os.path.join(self.out_path, "ComplexHeatmap.jpg")  # JPG 檔案路徑

        # 刪除舊檔案
        for old_file in [pdf_path, jpg_path]:
            if os.path.exists(old_file):
                os.remove(old_file)

        if not KALEIDO_AVAILABLE:  # 如果 Kaleido 未安裝，則返回空字串
            print("⚠️ 已略過 Plotly PDF/JPG 匯出：偵測到 Kaleido 未安裝。")
            return "", ""

        pdf_success = False  # PDF 匯出成功
        jpg_success = False  # JPG 匯出成功

        # 匯出 PDF（增加 scale 參數以提升解析度，特別是文字標籤的清晰度）
        try:
            fig.write_image(pdf_path, format="pdf", width=width, height=height, scale=4)
            if (
                os.path.exists(pdf_path) and os.path.getsize(pdf_path) > 0
            ):  # 如果 PDF 檔案存在且大小大於 0，則設置 PDF 匯出成功
                print(f"✅ PDF 已生成：{pdf_path}")
                pdf_success = True
        except Exception as e:
            print(f"⚠️ Plotly PDF 匯出失敗：{str(e)[:100]}")

        # 匯出 JPG
        try:
            fig.write_image(jpg_path, format="jpg", width=width, height=height, scale=4)
            if (
                os.path.exists(jpg_path) and os.path.getsize(jpg_path) > 0
            ):  # 如果 JPG 檔案存在且大小大於 0，則設置 JPG 匯出成功
                print(f"✅ JPG 已生成：{jpg_path}")
                jpg_success = True
        except Exception as e:
            print(f"⚠️ Plotly JPG 匯出失敗：{str(e)[:100]}")

        return (
            pdf_path if pdf_success else "",
            jpg_path if jpg_success else "",
        )  # 返回 PDF 和 JPG 檔案路徑

    # ========================================================================
    # 【內部方法】Plotly 配置：返回自訂的 Plotly 工具列配置
    #
    # _get_plotly_config: 返回自訂的 Plotly 工具列配置
    #   - 用途：自訂 Plotly 互動式圖表的工具列行為
    #   - 配置項目：
    #     * 禁用滾輪縮放（scrollZoom）
    #     * 禁用 Plotly 水印（displaylogo）
    #     * 禁用雙擊功能（doubleClick）
    #     * 移除工具列按鈕（zoom2d, pan2d, zoomIn2d, zoomOut2d, autoScale2d,
    #       resetScale2d, lasso2d, select2d）
    #   - 返回：Plotly 配置字典（dict）
    #   - 調用位置：plot_heatmap_with_annotations() 和 plot_heatmap_hybrid() 中
    # ========================================================================
    def _get_plotly_config(self) -> dict:
        """獲取 Plotly 配置

        返回自訂的 Plotly 工具列配置，包含縮放控制和按鈕設定。

        Returns:
            dict: Plotly 配置字典
        """
        return {  # 返回 Plotly 配置
            "scrollZoom": False,  # 禁用 Plotly 縮放
            "displaylogo": False,  # 禁用 Plotly 水印
            "doubleClick": False,  # 禁用 Plotly 雙擊
            "modeBarButtonsToRemove": [  # 移除 Plotly 模式欄按鈕
                "zoom2d",  # 縮放
                "pan2d",  # 平移
                "zoomIn2d",  # 放大
                "zoomOut2d",  # 縮小
                "autoScale2d",  # 自動縮放
                "resetScale2d",  # 重置縮放
                "lasso2d",  # 選擇
                "select2d",  # 選擇
            ],
        }

    # ========================================================================
    # 熱圖生成：繪製帶有多維標註的抗藥性熱圖
    #
    # plot_heatmap_with_annotations: 繪製帶有多維標註的抗藥性熱圖
    #
    # 【主要功能】
    #   生成包含以下組件的複合熱圖：
    #   - 左側階層樹狀圖（dendrogram）：樣本聚類關係
    #   - 左側物種標註（5 種物種）：AB, EF, KP, PA, SA
    #   - 中央主熱圖（抗藥性模式，可選）：顯示各樣本的抗藥性模式
    #   - 右側地理標註（8 個地理區域）：Asia, Middle_East, Europe 等
    #   - 右側年份標註（2000-2021，共 22 年）：樣本收集年份
    #   - 頂部頻率條形圖：各抗生素的平均抗藥性頻率
    #   - 頂部類別色帶（24 種類別）：抗生素類別顏色標註
    #
    # 【處理流程】
    #   1. 資料預處理：複製資料、設置索引、檢查抗藥性欄位
    #   2. 統計計算：計算頻率統計、設定抗生素類別顏色
    #   3. 標註準備：準備物種、地理、年份標註矩陣
    #   4. 版面計算：計算各組件尺寸（單元大小、側邊欄寬度、熱圖尺寸等）
    #   5. 圖形繪製：繪製主熱圖、階層樹狀圖、各類標註
    #   6. 圖形組合：組合所有子圖，生成最終 HTML 輸出
    #
    # 【返回】
    #   - str: HTML 互動式熱圖路徑
    #
    # 【調用位置】
    #   - run() 方法中（根據 with_annotations 參數決定是否調用）
    # ========================================================================
    def plot_heatmap_with_annotations(
        self,
        df: pd.DataFrame,
        show_main_heatmap: bool = True,
        initial_width: int = None,
        initial_height: int = None,
    ) -> str:
        """繪製帶有多維標註的抗藥性熱圖

        包含左側階層樹狀圖、物種標註、主熱圖、地理標註、年份標註、
        頂部頻率條形圖和類別色帶。

        Args:
            df: 合併後的抗藥性資料表
            show_main_heatmap: 是否顯示中央主熱圖（False 時僅保留標註視圖）
            initial_width: 初始圖表寬度（像素），None 時自動計算
            initial_height: 初始圖表高度（像素），None 時自動計算

        Returns:
            str: HTML 互動式熱圖路徑
        """
        # ====================================================================
        # 資料預處理
        #
        # 【資料準備】
        #   - 複製原始資料（用於 TSV 輸出）
        #   - 設置索引（以 Genome_ID 為索引）
        #
        # 【抗藥性欄位處理】
        #   - 驗證抗藥性欄位設定
        #   - 過濾並提取有效的抗藥性欄位
        #   - 設定抗藥性標籤及矩陣
        #   - 計算資料維度（行數、列數）
        #
        # 【統計計算】
        #   - 計算頻率統計（各抗生素的平均抗藥性頻率）
        #   - 計算最大頻率值（用於後續視覺化）
        #
        # 【顏色設定】
        #   - 解析抗生素類別 ID（從欄位名稱中提取）
        #   - 設定抗生素類別顏色映射
        # ====================================================================
        df_for_tsv = df.copy()
        df = df.set_index("Genome_ID")
        # 抗藥性欄位檢查
        if not self.profile_columns:
            raise ValueError("尚未設定抗藥性欄位，無法繪製標註熱圖。")
        profile_cols = [col for col in self.profile_columns if col in df.columns]
        if not profile_cols:
            raise ValueError("合併資料缺少抗藥性欄位，無法繪製標註熱圖。")
        # 設定抗藥性標籤及矩陣
        profile_labels = [str(col) for col in profile_cols]  # 設定抗藥性標籤
        matrix = df[profile_cols].to_numpy()  # 設定抗藥性矩陣
        n_rows, n_cols = len(df), len(profile_cols)  # 設定行數及列數

        # 頻率統計計算
        gene_freq = matrix.mean(axis=0)
        max_gene_freq = float(gene_freq.max()) if gene_freq.size else 0.0

        # 抗生素類別顏色設定：分割抗生素類別，設定抗生素類別顏色
        class_ids = []
        for col in profile_cols:
            parts = str(col).split(".")
            if len(parts) > 1 and parts[0].isdigit():
                class_ids.append(int(parts[0]))
            else:
                class_ids.append(0)

        class_colors = self.CLASS_COLORS

        # 左側物種標註
        species_cols = ["AB", "EF", "KP", "PA", "SA"]
        species_labels = [self.SPECIES_LABELS.get(col, col) for col in species_cols]
        species_color = "#60b6fb"
        species_matrices = []
        for col in species_cols:
            species_matrices.append(
                df[col].to_numpy() if col in df.columns else [0] * n_rows
            )

        # 右側地理標註
        region_cols = self.REGIONS
        region_color = "#009688"
        region_matrices = []
        for col in region_cols:
            region_matrices.append(
                df[col].to_numpy() if col in df.columns else [0] * n_rows
            )

        # 年份標註
        year_cols = [str(y) for y in range(2000, 2022)]
        year_color = "orange"
        year_matrices = []
        for col in year_cols:
            year_matrices.append(
                df[col].to_numpy() if col in df.columns else [0] * n_rows
            )

        # ====================================================================
        # 版面尺寸計算
        #
        # 【基礎單元尺寸】
        #   - 計算最大單元高度（基於最大熱圖高度和行數）
        #   - 計算單元大小（限制在 10-70 像素範圍內）
        #   - 設置單元寬度
        #
        # 【側邊欄寬度】
        #   - 階層樹狀圖寬度
        #   - 物種標註寬度
        #   - 地理區域標註寬度
        #   - 年份標註寬度
        #
        # 【其他組件尺寸】
        #   - 頻率條形圖高度
        #   - 抗生素類別顏色高度
        #   - 標籤高度（基於最大標籤長度計算）
        #
        # 【主熱圖尺寸】
        #   - 主熱圖寬度（列數 × 單元寬度）
        #   - 主熱圖高度（行數 × 單元大小）
        # ====================================================================
        max_heatmap_height = 600  # 最大熱圖高度
        cm_to_px = 37.8  # 厘米轉像素

        if n_rows > 0:
            max_cell_height = max_heatmap_height / n_rows  # 計算最大單元高度
            cell_size = min(max(10, max_cell_height), 70)  # 計算單元大小
        else:
            cell_size = 70  # 如果行數為 0，則設置單元大小為 70

        cell_width = cell_size  # 設置單元寬度
        dendro_width = 400  # 設置階層樹狀圖寬度
        # 設置物種標註寬度：保持格子為正方形（寬度 = cell_size）
        annot_left_width = len(species_cols) * cell_size
        annot_right_region_width = len(region_cols) * cell_size  # 設置地理區域標註寬度
        annot_right_year_width = len(year_cols) * cell_size  # 設置年份標註寬度
        barplot_height = cm_to_px * 2  # 設置頻率條形圖高度
        class_height = cm_to_px * 0.5  # 設置抗生素類別顏色高度
        if profile_labels:
            max_label_length = max(
                len(label) for label in profile_labels
            )  # 計算最大標籤長度
            label_height = max(70, min(110, max_label_length * 2.2))  # 計算標籤高度
        else:
            label_height = 70  # 如果標籤不存在，則設置標籤高度為 70
        heatmap_width = n_cols * cell_width  # 設置主熱圖寬度
        heatmap_height = n_rows * cell_size  # 設置主熱圖高度

        # ====================================================================
        # 版面配置：根據是否顯示主熱圖，設置不同的版面配置
        # ====================================================================
        if show_main_heatmap:  # 顯示主熱圖模式：包含完整組件配置
            column_width_values = [  # 設置列寬值
                dendro_width,
                annot_left_width,
                heatmap_width,
                annot_right_region_width,
                annot_right_year_width,
            ]
            row_height_values = [  # 設置行高值
                heatmap_height,  # 設置主熱圖高度
                barplot_height,  # 設置頻率條形圖高度
                class_height,  # 設置抗生素類別顏色高度
            ]
            subplot_specs = [  # 設置子圖規格
                [
                    {"type": "scatter"},
                    {"type": "heatmap"},
                    {"type": "heatmap"},
                    {"type": "heatmap"},
                    {"type": "heatmap"},
                ],
                [None, None, {"type": "bar"}, None, None],
                [None, None, {"type": "heatmap"}, None, None],
            ]
            position_map = {  # 設置位置映射
                "dendro": (1, 1),  # 設置階層樹狀圖位置
                "species": (1, 2),  # 設置物種標註位置
                "heatmap": (1, 3),  # 設置主熱圖位置
                "region": (1, 4),  # 設置地理區域標註位置
                "year": (1, 5),  # 設置年份標註位置
                "bar": (2, 3),  # 設置頻率條形圖位置
                "class": (3, 3),  # 設置抗生素類別顏色位置
            }
            total_width = sum(column_width_values)  # 計算總寬度
            total_height = sum(row_height_values)  # 計算總高度
        else:  # 僅標註模式：不顯示主熱圖，僅保留標註視圖
            column_width_values = [  # 設置列寬值
                dendro_width,  # 設置階層樹狀圖寬度
                annot_left_width,  # 設置物種標註寬度
                annot_right_region_width,  # 設置地理區域標註寬度
                annot_right_year_width,  # 設置年份標註寬度
            ]
            row_height_values = [heatmap_height]  # 設置行高值，只有主熱圖高度
            subplot_specs = [  # 設置子圖規格
                [
                    {"type": "scatter"},  # 設置階層樹狀圖規格
                    {"type": "heatmap"},  # 設置物種標註規格
                    {"type": "heatmap"},  # 設置地理區域標註規格
                    {"type": "heatmap"},  # 設置年份標註規格
                ]
            ]
            position_map = {  # 設置位置映射
                "dendro": (1, 1),  # 設置階層樹狀圖位置
                "species": (1, 2),  # 設置物種標註位置
                "region": (1, 3),  # 設置地理區域標註位置
                "year": (1, 4),  # 設置年份標註位置
            }
            total_width = sum(column_width_values)  # 計算總寬度
            total_height = (
                heatmap_height if heatmap_height > 0 else 400
            )  # 計算總高度，如果主熱圖高度為 0，則設置為 400

        row_height_sum = (
            sum(row_height_values) if row_height_values else 1.0
        )  # 計算行高總和，如果行高不存在，則設置為 1.0
        column_width_sum = (
            sum(column_width_values) if column_width_values else 1.0
        )  # 計算列寬總和，如果列寬不存在，則設置為 1.0
        row_height_ratios = (
            [h / row_height_sum for h in row_height_values]
            if row_height_values
            else [1.0]  # 如果行高不存在，則設置行高比例為 1.0
        )
        column_width_ratios = (
            [w / column_width_sum for w in column_width_values]  # 計算列寬比例
            if column_width_values
            else [1.0]  # 如果列寬不存在，則設置列寬比例為 1.0
        )
        vertical_spacing_value = (
            0.001
            if show_main_heatmap
            else 0.003  # 增加垂直間距值，如果顯示主熱圖，則設置為 0.001，否則設置為 0.003，以減少 HTML 顯示擁擠
        )

        fig = make_subplots(  # 創建子圖
            rows=len(row_height_values),  # 設置行數，如果行高不存在，則設置為 1.0
            cols=len(column_width_values),  # 設置列數，如果列寬不存在，則設置為 1.0
            row_heights=row_height_ratios,  # 設置行高，如果行高不存在，則設置為 1.0
            column_widths=column_width_ratios,  # 設置列寬，如果列寬不存在，則設置為 1.0
            specs=subplot_specs,  # 設置子圖規格，如果子圖規格不存在，則設置為 None
            horizontal_spacing=0.002,  # 設置水平間距
            vertical_spacing=vertical_spacing_value,  # 設置垂直間距，如果顯示主熱圖，則設置為 0.0005，否則設置為 0.002
        )

        axis_name_map: Dict[Tuple[int, int], Tuple[str, str]] = (
            {}
        )  # 設置軸名稱映射，如果軸名稱映射不存在，則設置為空字典
        subplot_counter = 0  # 設置子圖計數器
        for r, row_spec in enumerate(
            subplot_specs
        ):  # 遍歷子圖規格，如果子圖規格不存在，則設置為 None
            for c, cell in enumerate(
                row_spec
            ):  # 遍歷子圖規格，如果子圖規格不存在，則設置為 None
                if cell is None:  # 如果子圖規格為空，則跳過
                    continue
                subplot_counter += 1  # 增加子圖計數器，如果子圖計數器不存在，則設置為 0
                suffix = (
                    "" if subplot_counter == 1 else str(subplot_counter)
                )  # 設置子圖後綴，如果子圖計數器為 1，則設置為空字串，否則設置為子圖計數器
                axis_name_map[(r + 1, c + 1)] = (
                    f"x{suffix}",  # 設置 x 軸名稱，如果 x 軸名稱不存在，則設置為空字串
                    f"y{suffix}",  # 設置 y 軸名稱，如果 y 軸名稱不存在，則設置為空字串
                )  # 設置軸名稱映射，如果軸名稱映射不存在，則設置為 x 軸名稱和 y 軸名稱

        # ====================================================================
        # 階層樹狀圖生成：生成樣本聚類的階層樹狀圖
        #
        # 【處理流程】
        #   1. 計算階層樹狀圖：使用 Ward 方法計算樣本間的距離和鏈接
        #   2. 創建階層樹狀圖：使用 Plotly figure_factory 創建樹狀圖
        #   3. 調整樹狀圖：翻轉 x 軸、隱藏圖例
        #   4. 添加到圖形：將樹狀圖添加到指定位置
        # ====================================================================
        linkage_matrix = sch.linkage(matrix, method="ward")  # 計算階層樹狀圖
        dendro = ff.create_dendrogram(  # 創建階層樹狀圖
            matrix,  # 設置階層樹狀圖矩陣數據
            orientation="left",  # 設置階層樹狀圖方向
            labels=None,  # 設置階層樹狀圖標籤
            linkagefun=lambda _: linkage_matrix,  # 設置階層樹狀圖鏈接函數
        )
        for trace in dendro["data"]:  # 遍歷階層樹狀圖的所有線段（trace）
            # 每個 trace 代表樹狀圖中的一條線段或分支
            trace["x"] = [-x for x in trace["x"]]  # 翻轉 x 軸，使樹狀圖向左延伸
            trace["showlegend"] = False  # 隱藏圖例，避免與其他圖例重疊
            fig.add_trace(  # 添加階層樹狀圖
                trace,  # 設置階層樹狀圖數據
                row=position_map["dendro"][0],  # 設置階層樹狀圖行位置
                col=position_map["dendro"][1],  # 設置階層樹狀圖列位置
            )

        # ====================================================================
        # 物種標註熱圖：生成物種標註熱圖
        #
        # 【處理流程】
        #   1. 計算物種矩陣：計算物種矩陣
        #   2. 遍歷行數：遍歷行數
        #   3. 設置行數據：設置行數據
        #   4. 添加物種矩陣數據：添加物種矩陣數據
        #   5. 添加物種標註熱圖：添加物種標註熱圖
        # ====================================================================
        species_combined = (
            []
        )  # 設置物種矩陣數據，如果物種矩陣數據不存在，則設置為空列表
        for i in range(n_rows):  # 遍歷行數，如果行數不存在，則設置為 0
            row_data = []  # 設置行數據，如果行數據不存在，則設置為空列表
            for (
                species_matrix
            ) in species_matrices:  # 遍歷物種矩陣，如果物種矩陣不存在，則設置為空列表
                row_data.append(
                    species_matrix[i]
                )  # 添加物種矩陣數據，如果物種矩陣數據不存在，則設置為空列表
            species_combined.append(
                row_data
            )  # 添加物種矩陣數據，如果物種矩陣數據不存在，則設置為空列表

        fig.add_trace(  # 添加物種標註熱圖，設置物種標註熱圖位置
            go.Heatmap(
                z=species_combined,  # 設置物種矩陣數據
                x=species_labels,  # 設置物種標籤
                y=df.index,  # 設置物種標註熱圖 y 軸標籤
                colorscale=[[0, "white"], [1, species_color]],  # 設置物種顏色
                showscale=False,  # 設置物種標註熱圖不顯示刻度
                hovertemplate="樣本 %{y}<br>%{x}<extra></extra>",  # 設置物種標註熱圖懸浮模板
                xgap=4,  # 增加 x 軸間距，為文字標籤提供更多空間（從 2 增加到 4）
                ygap=2,  # 設置物種標註熱圖 y 軸間距
            ),
            row=position_map["species"][0],  # 設置物種標註熱圖行位置
            col=position_map["species"][1],  # 設置物種標註熱圖列位置
        )

        # ====================================================================
        # 主熱圖（抗藥性模式，可選）：生成中央主熱圖，顯示各樣本的抗藥性模式
        #
        # 【處理流程】
        #   1. 計算顏色條位置：根據行索引和行高比例計算顏色條的位置和大小
        #   2. 創建主熱圖：使用抗藥性矩陣數據創建熱圖，顯示各樣本對各抗生素的抗藥性
        #   3. 設置顏色條：配置顏色條的長度、位置、刻度值等樣式
        #   4. 添加顏色條標籤：在顏色條左側添加 "SEV" 標籤註解
        #
        # 【顏色映射】
        #   - 0.0: 綠色 (#a5d96a) - 低抗藥性
        #   - 0.2: 淺綠 (#d9ef8b)
        #   - 0.5: 黃色 (#fedf8b) - 中等抗藥性
        #   - 0.8: 橙色 (#fdaf61)
        #   - 1.0: 紅色 (#f46c43) - 高抗藥性
        # ====================================================================
        if show_main_heatmap:
            # -----------------------------------------------
            # 計算顏色條位置和大小
            # -----------------------------------------------
            # 獲取主熱圖所在的行索引（從 1 開始轉換為從 0 開始）
            heatmap_row_idx = (
                position_map["heatmap"][0] - 1
            )  # 主熱圖行索引，如果主熱圖行索引不存在，則設置為 0

            # 根據行索引計算顏色條的長度和位置
            if 0 <= heatmap_row_idx < len(row_height_ratios):
                # 獲取主熱圖所在行的相對高度比例
                base_len = row_height_ratios[heatmap_row_idx]
                # 計算可用長度：扣除垂直間距，限制在 0.1 到 0.98 之間
                available_len = max(
                    min(base_len - vertical_spacing_value, 0.98),
                    0.1,
                )
                # 顏色條長度 = 可用長度的 80%（最小 0.1）
                colorbar_len = max(available_len * 0.8, 0.1)
                # 計算主熱圖行的頂部位置（從上往下）
                heatmap_row_top = 1 - sum(row_height_ratios[:heatmap_row_idx])
                # 顏色條 y 軸位置 = 行的中心位置
                colorbar_y = heatmap_row_top - base_len / 2
            else:
                # 如果行索引無效，使用預設值
                colorbar_len = 0.5
                colorbar_y = 0.5
            # 顏色條 x 軸位置（放在圖形右側，確保刻度不被裁切）
            colorbar_x = 1.05
            # -----------------------------------------------
            # 創建主熱圖
            # -----------------------------------------------
            fig.add_trace(
                go.Heatmap(
                    z=matrix,  # 抗藥性矩陣數據
                    x=profile_labels,  # x 軸標籤（抗生素名稱）
                    y=df.index,  # y 軸標籤（樣本 ID）
                    colorscale=[  # 顏色映射：綠色（低）→ 黃色（中）→ 紅色（高）
                        [0.0, "#a5d96a"],  # 綠色
                        [0.2, "#d9ef8b"],  # 淺綠
                        [0.5, "#fedf8b"],  # 黃色
                        [0.8, "#fdaf61"],  # 橙色
                        [1.0, "#f46c43"],  # 紅色
                    ],
                    colorbar=dict(  # 顏色條配置
                        len=colorbar_len,  # 長度
                        y=colorbar_y,  # y 軸位置
                        yanchor="middle",  # 垂直對齊：居中
                        tickvals=[0, 20, 40, 60, 80, 100],  # 刻度值
                        tickfont=dict(color="#444", size=11),  # 刻度字體
                        x=colorbar_x,  # x 軸位置
                        xanchor="left",  # 水平對齊：左對齊
                        xpad=12,  # x 軸間距
                        thickness=18,  # 顏色條厚度
                    ),
                    showscale=True,  # 顯示顏色條
                    hovertemplate="抗生素 %{x}<br>樣本 %{y}<br>值 %{z}<extra></extra>",
                    xgap=0.5,  # x 軸格子間距
                    ygap=0.5,  # y 軸格子間距
                ),
                row=position_map["heatmap"][0],  # 行位置
                col=position_map["heatmap"][1],  # 列位置
            )
            # -----------------------------------------------
            # 添加顏色條標籤註解
            # -----------------------------------------------
            # 計算標籤位置：放在顏色條頂端左側
            # colorbar_x = 1.05（顏色條左邊緣位置），標籤放在其左側
            annotation_x = colorbar_x - 0.002
            # 標籤 y 軸位置：略低於顏色條頂端
            annotation_y = colorbar_y + colorbar_len / 2 - 0.003

            fig.add_annotation(
                x=annotation_x,
                y=annotation_y,
                xref="paper",  # 使用紙張座標系統
                yref="paper",
                text="<b>S<sub>EV</sub></b>",  # 標籤文字（粗體，EV 為下標）
                showarrow=False,  # 不顯示箭頭
                align="center",
                xanchor="right",  # 右對齊：標籤右邊緣對齊顏色條左側
                yanchor="bottom",  # 底部對齊：標籤底部對齊顏色條頂端
                font=dict(size=14, color="#444"),
                xshift=0,  # 垂直對齊顏色條邊緣
                yshift=-6,  # 再向下移動，避免貼近頂部
            )
        # ----------------------------------------------------------------------
        # 地理標註熱圖：生成右側地理標註熱圖（8 個地理區域）
        # ----------------------------------------------------------------------
        # 合併地理區域矩陣：將 8 個地理區域的 one-hot 編碼矩陣合併成一個組合矩陣
        region_combined = []
        for i in range(n_rows):
            row_data = []
            for region_matrix in region_matrices:
                row_data.append(region_matrix[i])
            region_combined.append(row_data)

        # 創建地理標註熱圖
        fig.add_trace(
            go.Heatmap(
                z=region_combined,  # 地理區域矩陣數據
                x=region_cols,  # x 軸標籤（地理區域名稱）
                y=df.index,  # y 軸標籤（樣本 ID）
                colorscale=[
                    [0, "white"],
                    [1, region_color],
                ],  # 顏色：白色（不屬於）→ 青色（屬於）
                showscale=False,  # 不顯示顏色條
                hovertemplate="樣本 %{y}<br>地理 %{x}<extra></extra>",
                xgap=2,  # x 軸格子間距
                ygap=2,  # y 軸格子間距
            ),
            row=position_map["region"][0],  # 行位置
            col=position_map["region"][1],  # 列位置
        )

        # ----------------------------------------------------------------------
        # 年份標註熱圖：生成右側年份標註熱圖（2000-2021，共 22 年）
        # ----------------------------------------------------------------------
        # 合併年份矩陣：將 22 個年份的 one-hot 編碼矩陣合併成一個組合矩陣
        year_combined = []
        for i in range(n_rows):
            row_data = []
            for year_matrix in year_matrices:
                row_data.append(year_matrix[i])
            year_combined.append(row_data)

        # 創建年份標註熱圖
        fig.add_trace(
            go.Heatmap(
                z=year_combined,  # 年份矩陣數據
                x=year_cols,  # x 軸標籤（年份）
                y=df.index,  # y 軸標籤（樣本 ID）
                colorscale=[
                    [0, "white"],
                    [1, year_color],
                ],  # 顏色：白色（不屬於）→ 橙色（屬於）
                showscale=False,  # 不顯示顏色條
                hovertemplate="樣本 %{y}<br>年份 %{x}<extra></extra>",
                xgap=2,  # x 軸格子間距
                ygap=2,  # y 軸格子間距
            ),
            row=position_map["year"][0],  # 行位置
            col=position_map["year"][1],  # 列位置
        )
        # ----------------------------------------------------------------------
        # 頂部頻率條形圖與類別色帶（只在顯示主熱圖時呈現）
        # ----------------------------------------------------------------------
        if show_main_heatmap:
            # 創建條形圖，顯示每個抗生素在所有樣本中的平均抗藥性頻率
            fig.add_trace(
                go.Bar(
                    x=profile_labels,  # x 軸：抗生素名稱
                    y=gene_freq,  # y 軸：平均抗藥性頻率
                    marker=dict(
                        color="#C54032", line=dict(width=0)
                    ),  # 紅色條形，無邊框
                    showlegend=False,  # 不顯示圖例
                    hovertemplate="基因 %{x}<br>平均抗藥性 %{y:.2f}<extra></extra>",
                ),
                row=position_map["bar"][0],  # 行位置
                col=position_map["bar"][1],  # 列位置
            )

            # 設置 y 軸範圍和刻度標籤
            bar_row, bar_col = position_map["bar"]
            if max_gene_freq > 0:
                # 如果有數據，設置 y 軸範圍為 [0, 最大頻率 × 1.1]（留 10% 空間）
                fig.update_yaxes(
                    range=[0, max_gene_freq * 1.1],
                    showticklabels=True,
                    row=bar_row,
                    col=bar_col,
                )
            else:
                # 如果沒有數據，只顯示刻度標籤
                fig.update_yaxes(showticklabels=True, row=bar_row, col=bar_col)

            # 添加 "Freq." 標籤註解
            freq_xref, freq_yref = axis_name_map[(bar_row, bar_col)]
            fig.add_annotation(
                x=(
                    profile_labels[-1] if profile_labels else 0
                ),  # x 位置：最後一個抗生素位置
                y=(
                    max_gene_freq * 0.9 if max_gene_freq > 0 else 0.5
                ),  # y 位置：90% 高度處
                xref=freq_xref,  # x 軸參考
                yref=freq_yref,  # y 軸參考
                text="Freq.",  # 標籤文字
                font=dict(size=14, color="#444"),
                showarrow=False,
                xanchor="right",  # 右對齊
                yanchor="top",  # 頂部對齊
                align="left",
                xshift=45,  # 水平偏移：往右移動 45 像素
                yshift=-20,  # 垂直偏移：往下移動 20 像素，避免與頂部標註重疊
            )

            # -----------------------------------------------
            # 類別色帶：顯示抗生素類別顏色標註（24 種類別）
            # -----------------------------------------------
            # 創建熱圖，為每個抗生素顯示其對應的類別顏色
            fig.add_trace(
                go.Heatmap(
                    z=[[i for i in range(n_cols)]],  # 數據：每個抗生素的索引值
                    x=profile_labels,  # x 軸：抗生素名稱
                    y=["Class"],  # y 軸：固定為 "Class"
                    colorscale=[
                        [
                            i / (n_cols - 1 if n_cols > 1 else 1),  # 顏色位置（0 到 1）
                            class_colors.get(class_ids[i], "white"),  # 對應的類別顏色
                        ]
                        for i in range(n_cols)  # 為每個抗生素生成顏色映射
                    ],
                    showscale=False,  # 不顯示顏色條
                    hovertemplate="基因 %{x}<br>類別 %{z}<extra></extra>",
                    xgap=2,  # x 軸格子間距
                    ygap=2,  # y 軸格子間距
                ),
                row=position_map["class"][0],  # 行位置
                col=position_map["class"][1],  # 列位置
            )

            # 添加 "Class" 標籤註解
            class_row, class_col = position_map["class"]
            class_xref, class_yref = axis_name_map[(class_row, class_col)]
            fig.add_annotation(
                x=(
                    profile_labels[-1] if profile_labels else 0
                ),  # x 位置：最後一個抗生素位置
                y=0.85,  # y 位置：固定位置
                xref=class_xref,  # x 軸參考
                yref=class_yref,  # y 軸參考
                text="Class",  # 標籤文字
                font=dict(size=14, color="#444"),
                showarrow=False,
                xanchor="right",  # 右對齊
                yanchor="top",  # 頂部對齊
                align="left",
                xshift=45,  # 水平偏移：往右移動 45 像素
                yshift=-15,  # 垂直偏移：往下移動 15 像素，避免與頂部標註重疊
            )

        # -----------------------------------------------
        # 座標軸設定
        # -----------------------------------------------
        # 設置參考軸並同步第一行所有子圖的 y 軸
        # 選擇參考軸：如果顯示主熱圖則使用主熱圖的 y 軸，否則使用物種標註的 y 軸
        reference_key = "heatmap" if show_main_heatmap else "species"
        ref_axis = axis_name_map[position_map[reference_key]][1]

        # 獲取第一行所有子圖的位置（row=1）
        first_row_positions = [pos for pos in position_map.values() if pos[0] == 1]

        # 同步第一行所有子圖的 y 軸設置
        for row_idx, col_idx in first_row_positions:
            fig.update_yaxes(
                matches=ref_axis,  # 與參考軸匹配（使用相同的 y 軸範圍）
                autorange="reversed",  # 反轉 y 軸順序（從上到下）
                showticklabels=False,  # 隱藏 y 軸刻度標籤
                row=row_idx,
                col=col_idx,
            )
            # 隱藏第一行所有子圖的 x 軸刻度標籤
            fig.update_xaxes(showticklabels=False, row=row_idx, col=col_idx)

        # -----------------------------------------------
        # 設置頂部組件（頻率條形圖和類別色帶）的座標軸（僅在顯示主熱圖時）
        # -----------------------------------------------
        if show_main_heatmap:
            bar_row, bar_col = position_map["bar"]
            class_row, class_col = position_map["class"]

            # 隱藏頻率條形圖的 x 軸刻度標籤
            fig.update_xaxes(showticklabels=False, row=bar_row, col=bar_col)

            # 隱藏類別色帶的 x 軸和 y 軸刻度標籤
            fig.update_xaxes(showticklabels=False, row=class_row, col=class_col)
            fig.update_yaxes(showticklabels=False, row=class_row, col=class_col)

            # 在類別色帶底部顯示抗生素名稱標籤（作為整個熱圖的 x 軸標籤）
            fig.update_xaxes(
                showticklabels=True,  # 顯示刻度標籤
                tickangle=-90,  # 標籤旋轉 -90 度（垂直顯示）
                tickfont=dict(
                    size=9,
                    color="#333333",
                    family="Arial Bold, Arial, sans-serif",
                ),
                side="bottom",  # 標籤顯示在底部
                type="category",  # 類別型座標軸
                categoryorder="array",  # 按照指定陣列順序排列
                categoryarray=profile_labels,  # 類別陣列
                tickmode="array",  # 使用陣列模式設置刻度
                tickvals=profile_labels,  # 刻度值
                ticktext=profile_labels,  # 刻度文字
                ticklabelposition="outside",  # 標籤位置：外部
                automargin=True,  # 自動調整邊距
                row=class_row,
                col=class_col,
            )

        # 物種標註熱圖的 x 軸標籤
        # 優化文字標籤清晰度：增加字體大小，保持格子為正方形
        species_row, species_col = position_map["species"]
        fig.update_xaxes(
            showticklabels=True,  # 顯示刻度標籤
            tickangle=-90,  # 標籤旋轉 -90 度（垂直顯示）
            tickfont=dict(
                size=9, family="Arial Bold, Arial, sans-serif"
            ),  # 字體大小設為 9，減少 HTML 顯示擁擠，PDF/PNG 匯出時會通過 scale 參數提升清晰度
            side="top",  # 標籤顯示在頂部
            tickmode="array",  # 使用陣列模式設置刻度
            tickvals=list(range(len(species_labels))),  # 刻度值（索引）
            ticktext=species_labels,  # 刻度文字（物種名稱）
            ticklabelposition="outside top",  # 標籤位置：頂部外部（不影響格子尺寸）
            ticklen=0,  # 不顯示刻度線，只顯示標籤
            automargin=True,  # 自動調整邊距，為文字標籤預留空間
            row=species_row,
            col=species_col,
        )

        # 地理標註熱圖的 x 軸標籤
        region_row, region_col = position_map["region"]
        fig.update_xaxes(
            showticklabels=True,  # 顯示刻度標籤
            tickangle=-90,  # 標籤旋轉 -90 度（垂直顯示）
            tickfont=dict(size=9, family="Arial Bold, Arial, sans-serif"),
            side="top",  # 標籤顯示在頂部
            ticklabelposition="outside top",  # 標籤位置：頂部外部
            automargin=True,  # 自動調整邊距
            tickmode="array",  # 使用陣列模式設置刻度
            tickvals=region_cols,  # 刻度值（地理區域名稱）
            ticktext=region_cols,  # 刻度文字（地理區域名稱）
            row=region_row,
            col=region_col,
        )

        # 年份標註熱圖的 x 軸標籤
        year_row, year_col = position_map["year"]
        fig.update_xaxes(
            showticklabels=True,  # 顯示刻度標籤
            tickangle=-90,  # 標籤旋轉 -90 度（垂直顯示）
            tickfont=dict(size=9, family="Arial Bold, Arial, sans-serif"),
            side="top",  # 標籤顯示在頂部
            ticklabelposition="outside top",  # 標籤位置：頂部外部
            automargin=True,  # 自動調整邊距
            tickmode="array",  # 使用陣列模式設置刻度
            tickvals=year_cols,  # 刻度值（年份）
            ticktext=year_cols,  # 刻度文字（年份）
            row=year_row,
            col=year_col,
        )

        # -----------------------------------------------
        # 格線繪製：為標註熱圖添加格線，提升可讀性
        # -----------------------------------------------
        shapes = []  # 儲存所有格線形狀
        grid_color = "rgba(200, 200, 200, 0.5)"  # 格線顏色（半透明灰色）

        def add_grid_lines(row: int, col: int, n_cols_local: int, n_rows_local: int):
            """為指定子圖添加格線

            Args:
                row: 子圖行位置
                col: 子圖列位置
                n_cols_local: 列數（格子數量）
                n_rows_local: 行數（格子數量）
            """
            x_ref, y_ref = axis_name_map[(row, col)]

            # 繪製垂直格線（列之間的分隔線）
            for i in range(n_cols_local + 1):
                shapes.append(
                    dict(
                        type="line",
                        xref=x_ref,  # x 軸參考
                        yref=y_ref,  # y 軸參考
                        x0=i - 0.5,  # 起始 x 座標（格子邊界）
                        x1=i - 0.5,  # 結束 x 座標（垂直線）
                        y0=-0.5,  # 起始 y 座標（頂部）
                        y1=n_rows_local - 0.5,  # 結束 y 座標（底部）
                        line=dict(color=grid_color, width=1),
                    )
                )

            # 繪製水平格線（行之間的分隔線）
            for i in range(n_rows_local + 1):
                shapes.append(
                    dict(
                        type="line",
                        xref=x_ref,  # x 軸參考
                        yref=y_ref,  # y 軸參考
                        x0=-0.5,  # 起始 x 座標（左側）
                        x1=n_cols_local - 0.5,  # 結束 x 座標（右側）
                        y0=i - 0.5,  # 起始 y 座標（格子邊界）
                        y1=i - 0.5,  # 結束 y 座標（水平線）
                        line=dict(color=grid_color, width=1),
                    )
                )

        # 為標註熱圖添加格線
        add_grid_lines(
            row=species_row,
            col=species_col,
            n_cols_local=len(species_cols),  # 5 個物種
            n_rows_local=n_rows,
        )
        add_grid_lines(
            row=region_row,
            col=region_col,
            n_cols_local=len(region_cols),  # 8 個地理區域
            n_rows_local=n_rows,
        )
        add_grid_lines(
            row=year_row,
            col=year_col,
            n_cols_local=len(year_cols),  # 22 個年份
            n_rows_local=n_rows,
        )

        # 為類別色帶添加格線（僅在顯示主熱圖時）
        if show_main_heatmap:
            class_row, class_col = position_map["class"]
            x_ref_class, y_ref_class = axis_name_map[(class_row, class_col)]

            # 繪製垂直格線（抗生素之間的分隔線）
            for i in range(n_cols + 1):
                shapes.append(
                    dict(
                        type="line",
                        xref=x_ref_class,
                        yref=y_ref_class,
                        x0=i - 0.5,
                        x1=i - 0.5,
                        y0=-0.5,  # 頂部
                        y1=0.5,  # 底部（類別色帶只有一行）
                        line=dict(color=grid_color, width=1),
                    )
                )

            # 繪製頂部水平格線
            shapes.append(
                dict(
                    type="line",
                    xref=x_ref_class,
                    yref=y_ref_class,
                    x0=-0.5,
                    x1=n_cols - 0.5,
                    y0=-0.5,
                    y1=-0.5,
                    line=dict(color=grid_color, width=1),
                )
            )

            # 繪製底部水平格線
            shapes.append(
                dict(
                    type="line",
                    xref=x_ref_class,
                    yref=y_ref_class,
                    x0=-0.5,
                    x1=n_cols - 0.5,
                    y0=0.5,
                    y1=0.5,
                    line=dict(color=grid_color, width=1),
                )
            )

        # -----------------------------------------------
        # 邊距和尺寸設置：計算圖表的邊距和最終尺寸
        # -----------------------------------------------
        # 底部邊距：為 x 軸標籤預留空間
        bottom_margin = 80

        # 頂部邊距：統一上方邊距，確保 PNG/PDF/HTML 格式一致
        # 標題高度約 28px (字體大小) + title_pad_top (20px) + title_pad_bottom (10px) + 額外空間
        # 當主熱圖隱藏時，需要更多空間來容納標題和頂部標註（物種、地理、年份標註的 x 軸標籤）
        # 物種標註文字標籤字體大小設為 9，增加頂部邊距以提供更舒適的顯示空間
        top_margin = 150 if show_main_heatmap else 190

        # 左側邊距：為 y 軸標籤預留空間
        left_margin = 30

        # 右側邊距：顯示主熱圖時需要更多空間來容納 colorbar 和標籤
        right_margin = 80 if show_main_heatmap else 30

        # 計算布局高度：繪圖區域的高度，不包含 margin（margin 是額外的空間）
        layout_height = (
            total_height + label_height if show_main_heatmap else total_height + 200
        )

        # 計算最終圖表尺寸
        # 如果提供了初始尺寸參數，使用它們；否則使用計算出的完整圖表尺寸
        if initial_width is not None:
            final_width = initial_width
        else:
            # 自動計算：使用 total_width，標題會相對於這個寬度居中
            final_width = total_width

        if initial_height is not None:
            final_height = initial_height
        else:
            # 自動計算：使用 layout_height
            final_height = layout_height

        # -----------------------------------------------
        # HTML 輸出與互動功能設定
        # -----------------------------------------------
        html_path = os.path.join(self.out_path, "ComplexHeatmap.html")  # 設置 HTML 路徑

        # 標題位置設置：統一標題位置和間距，確保 PNG/PDF/HTML 格式一致
        # 當主熱圖隱藏時，調整標題位置以避免與頂部標註重疊
        title_y = 0.98  # 固定標題垂直位置（相對於圖表高度）
        title_pad_top = 20  # 標題上方邊距
        # 當主熱圖隱藏時，增加標題下方邊距以確保與頂部標註（物種、地理、年份標註的 x 軸標籤）有足夠間距
        title_pad_bottom = 10 if show_main_heatmap else 50

        # -----------------------------------------------
        # 更新圖表布局和座標軸設置
        # -----------------------------------------------
        # 更新布局：設置圖表的整體樣式和配置
        fig.update_layout(
            width=final_width,  # 圖表寬度
            height=final_height,  # 圖表高度
            title=(
                dict(
                    text="Heatmap of antimicrobial resistance profiles",  # 標題文字
                    x=0.5,  # 標題水平位置（居中）
                    xanchor="center",  # 水平對齊：居中
                    y=title_y,  # 標題垂直位置
                    yanchor="top",  # 垂直對齊：頂部
                    pad=dict(
                        t=title_pad_top, b=title_pad_bottom
                    ),  # 標題上下邊距（統一值，確保所有格式一致）
                    font=dict(size=28, family="Arial", color="black"),  # 標題字體
                )
                if show_main_heatmap
                else None
            ),  # 無主熱圖時隱藏標題
            showlegend=False,  # 不顯示圖例
            margin=dict(
                l=left_margin, r=right_margin, t=top_margin, b=bottom_margin
            ),  # 圖表邊距（左、右、上、下）
            paper_bgcolor="white",  # 紙張背景顏色
            plot_bgcolor="white",  # 繪圖區域背景顏色
            hovermode="closest",  # 懸停模式：顯示最接近的數據點
            shapes=shapes,  # 格線形狀
            dragmode=False,  # 禁用 Plotly 拖曳，使用自訂控制
            hoverdistance=5,  # 懸停觸發距離（像素）
            spikedistance=10,  # 尖刺線觸發距離（像素）
            uirevision="heatmap_fixed",  # UI 版本標識（防止自動重置）
        )

        # 更新所有 x 軸：設置懸停尖刺線和固定範圍
        fig.update_xaxes(
            showspikes=True,  # 顯示尖刺線（懸停時的輔助線）
            spikemode="across",  # 尖刺模式：橫跨整個圖表
            spikesnap="cursor",  # 尖刺捕捉：跟隨游標
            spikethickness=1,  # 尖刺線厚度
            showline=True,  # 顯示軸線
            fixedrange=True,  # 固定範圍（禁用縮放）
            automargin=True,  # 自動調整邊距
        )

        # 更新所有 y 軸：設置懸停尖刺線和固定範圍
        fig.update_yaxes(
            showspikes=True,  # 顯示尖刺線（懸停時的輔助線）
            spikemode="across",  # 尖刺模式：橫跨整個圖表
            spikesnap="cursor",  # 尖刺捕捉：跟隨游標
            spikethickness=1,  # 尖刺線厚度
            showline=True,  # 顯示軸線
            fixedrange=True,  # 固定範圍（禁用縮放）
            automargin=True,  # 自動調整邊距
        )

        # -----------------------------------------------
        # 生成 HTML 和 TSV 內容
        # -----------------------------------------------
        # 生成圖表 HTML（僅包含圖表部分，不包含完整 HTML 結構）
        inner_html = fig.to_html(
            include_plotlyjs="cdn",  # 使用 CDN 引用 Plotly JS 庫
            full_html=False,  # 不生成完整 HTML 文檔（只生成圖表部分）
            config=self._get_plotly_config(),  # 使用自訂 Plotly 配置
        )

        # 生成 TSV 摘要內容（用於嵌入到 HTML 的 JavaScript 中）
        tsv_content = self._generate_tsv_content(df_for_tsv)

        # JavaScript 互動功能：Query 行高亮和標籤調整
        # 功能包括：
        #   1. 調整抗生素標籤位置（向左偏移）
        #   2. Query 行標籤高亮（紅色加粗）
        #   3. 添加圖例說明區域（預留，目前為空）
        query_highlight_js = """
        <script>
        document.addEventListener("DOMContentLoaded", function() {
            // 獲取 Plotly 圖表容器
            const plotDiv = document.querySelector('.js-plotly-plot');
            if (!plotDiv) return;

            // -----------------------------------------------
            // 調整抗生素標籤位置：向左偏移 8 像素，改善對齊效果
            // -----------------------------------------------
            function adjustAntibioticLabels() {
                // 找到所有底部 x 軸標籤（抗生素標籤）
                const xAxisLabels = plotDiv.querySelectorAll('.xtick text');
                xAxisLabels.forEach(label => {
                    // 向左偏移 8 像素
                    label.style.transform = 'translateX(-8px)';
                });
            }

            // -----------------------------------------------
            // Query 行高亮處理：在圖表渲染完成後執行
            // -----------------------------------------------
            plotDiv.on('plotly_afterplot', function() {
                // 調整抗生素標籤位置
                adjustAntibioticLabels();
                
                // 獲取所有熱圖的矩形元素和 y 軸標籤
                const heatmapRects = plotDiv.querySelectorAll('.hm rect');
                const yLabels = plotDiv.querySelectorAll('.ytick text');
                
                // 找到 Query 對應的 y 軸索引
                let queryIndex = -1;
                yLabels.forEach((label, idx) => {
                    if (label.textContent.trim() === 'Query') {
                        queryIndex = idx;
                        // Query 標籤樣式：紅色、加粗、較大字體
                        label.style.fill = 'red';
                        label.style.fontWeight = 'bold';
                        label.style.fontSize = '14px';
                    }
                });
                
                // 為 Query 行的所有格子添加紅色邊框（預留功能）
                // 注意：目前僅標記了位置，實際實現需要根據渲染情況調整
                if (queryIndex >= 0) {
                    heatmapRects.forEach(rect => {
                        const y = parseFloat(rect.getAttribute('y'));
                        // TODO: 根據 y 座標判斷是否為 Query 行，添加紅色邊框
                    });
                }
            });

            // -----------------------------------------------
            // 添加圖例說明區域（預留，目前為空容器）
            // -----------------------------------------------
            const legendDiv = document.createElement('div');
            legendDiv.style.cssText = `
                position: fixed;      /* 固定定位 */
                top: 10px;            /* 距離頂部 10px */
                right: 10px;          /* 距離右側 10px */
                background: white;    /* 白色背景 */
                padding: 15px;        /* 內邊距 */
                border: 1px solid #ccc;  /* 邊框 */
                border-radius: 8px;   /* 圓角 */
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);  /* 陰影效果 */
                font-family: Arial, sans-serif;
                font-size: 12px;
                z-index: 1000;        /* 確保在最上層 */
            `;
            document.body.appendChild(legendDiv);
        });
        </script>
        """

        # -----------------------------------------------
        # 準備 HTML 模板所需的數據
        # -----------------------------------------------
        # 將 TSV 內容轉義以便嵌入 JavaScript（避免特殊字符衝突）
        tsv_content_escaped = (
            tsv_content.replace("\\", "\\\\").replace("`", "\\`").replace("$", "\\$")
        )

        # 生成文件相對路徑（相對於 HTML 文件，用於前端匯出功能）
        # HTML 和這些文件在同一個目錄，所以相對路徑就是文件名
        pdf_filename = "ComplexHeatmap.pdf"
        pdf_relative_path = pdf_filename

        jpg_filename = "ComplexHeatmap.jpg"
        jpg_relative_path = jpg_filename

        tsv_filename = "heatmap_summary.tsv"
        tsv_relative_path = tsv_filename

        wrapped_html = f"""
        <!DOCTYPE html>
        <html>
        <head>
            <!-- 頁面基本設置 -->
            <meta charset="utf-8">
            <title>ComplexHeatmap - Antimicrobial Resistance Analysis</title>
            
            <!-- JavaScript 變數定義：嵌入後端數據供前端使用 -->
            <script>
                // 文件路徑：供前端匯出功能使用
                const pdfFilePath = '{pdf_relative_path}';
                const jpgFilePath = '{jpg_relative_path}';
                const tsvFilePath = '{tsv_relative_path}';
                
                // 圖表尺寸：確保前端 PNG/PDF 匯出與後端一致
                const chartWidth = {final_width};
                const chartHeight = {final_height};
                
                // TSV 摘要內容：嵌入到 JavaScript 中，供前端匯出功能使用
                const tsvSummaryData = `{tsv_content_escaped}`;
            </script>
            
            <!-- CSS 樣式定義 -->
            <style>
                /* -----------------------------------------------
                   頁面整體樣式
                   ----------------------------------------------- */
                body {{
                    background-color: #f5f5f5;  /* 淺灰色背景 */
                    font-family: 'Arial', 'Helvetica', sans-serif;
                    text-align: center;
                    margin: 0;
                    padding: 0;
                    display: flex;  /* Flexbox 布局 */
                    flex-direction: column;  /* 垂直排列 */
                    min-height: 100vh;  /* 最小高度為視窗高度 */
                }}
                
                /* -----------------------------------------------
                   頁首樣式
                   ----------------------------------------------- */
                .header {{
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);  /* 漸層背景 */
                    color: white;
                    padding: 20px;
                    box-shadow: 0 2px 8px rgba(0,0,0,0.1);  /* 陰影效果 */
                }}
                .header h1 {{
                    margin: 0;
                    font-size: 24px;
                    font-weight: 600;
                }}
                .header p {{
                    margin: 5px 0 0 0;
                    font-size: 14px;
                    opacity: 0.9;
                }}
                
                /* -----------------------------------------------
                   圖表容器樣式
                   ----------------------------------------------- */
                .chart-container {{
                    display: flex;
                    justify-content: center;  /* 水平居中 */
                    align-items: flex-start;  /* 從頂部開始對齊 */
                    flex: 1;  /* 佔據剩餘空間 */
                    padding: 0 20px 20px 20px;  /* 只保留左右和下方 padding */
                    width: 100%;
                    box-sizing: border-box;
                }}
                
                /* 圖表滾動容器（舊版樣式，用於非縮放模式） */
                .chart-scroll {{
                    max-width: 85vw;  /* 最大寬度為視窗寬度的 85% */
                    overflow: hidden;  /* 隱藏滾動條，改用拖曳移動 */
                    border: 2px solid #e0e0e0;
                    border-radius: 10px;
                    box-shadow: 0 4px 16px rgba(0, 0, 0, 0.12);
                    background-color: #ffffff;
                    display: inline-block;
                    padding-top: 0;  /* 移除上方 padding */
                }}
                
                /* 確保 Plotly 圖表完整顯示 */
                .chart-scroll .js-plotly-plot {{
                    width: 100%;
                    height: 100%;
                }}
                
                /* 圖表包裝容器：作為視窗，隱藏滾動條 */
                .chart-wrapper {{
                    display: inline-block;
                    max-width: 85vw;  /* 最大寬度 */
                    max-height: 90vh;  /* 最大高度 */
                    overflow: hidden;  /* 隱藏溢出內容 */
                    position: relative;
                    border: 2px solid #e0e0e0;
                    border-radius: 10px;
                    box-shadow: 0 4px 16px rgba(0, 0, 0, 0.12);
                    background-color: #ffffff;
                }}
                
                /* 可縮放的圖表容器：支援拖曳和縮放 */
                .chart-scroll.zoomable {{
                    transform-origin: top left;  /* 變換原點：左上角 */
                    cursor: grab;  /* 游標：抓取 */
                    transition: transform 0.1s ease-out;  /* 平滑過渡效果 */
                    overflow: visible;  /* 允許內容溢出 */
                    border: none;  /* 移除邊框 */
                    border-radius: 0;
                    box-shadow: none;
                    background-color: transparent;
                    padding-top: 0;
                    width: fit-content;  /* 寬度適應內容 */
                    height: fit-content;  /* 高度適應內容 */
                }}
                
                /* 拖曳狀態：改變游標樣式 */
                .chart-scroll.zoomable.dragging {{
                    cursor: grabbing;  /* 游標：抓取中 */
                    transition: none;  /* 拖曳時禁用過渡效果 */
                }}
                
                /* -----------------------------------------------
                   頁尾樣式
                   ----------------------------------------------- */
                .footer {{
                    margin-top: 20px;
                    padding: 15px;
                    font-size: 12px;
                    color: #666;
                    background-color: #f9f9f9;
                    border-top: 1px solid #e0e0e0;
                }}
                
                /* -----------------------------------------------
                   縮放控制按鈕樣式
                   ----------------------------------------------- */
                .zoom-controls {{
                    position: fixed;  /* 固定定位 */
                    top: 60px;  /* 距離頂部 60px */
                    right: 20px;  /* 距離右側 20px */
                    background: white;
                    padding: 10px;
                    border-radius: 8px;
                    box-shadow: 0 2px 8px rgba(0,0,0,0.15);
                    z-index: 1001;  /* 確保在最上層 */
                    display: block;
                }}
                
                /* 按鈕基本樣式 */
                .zoom-controls button {{
                    display: block;  /* 垂直排列 */
                    width: 40px;
                    height: 40px;
                    margin: 2px 0;
                    border: 1px solid #ccc;
                    border-radius: 4px;
                    background: #f8f9fa;
                    cursor: pointer;
                    font-size: 18px;
                    font-weight: bold;
                    color: #333;
                    transition: all 0.2s;  /* 平滑過渡效果 */
                }}
                
                /* 文字按鈕樣式（Reset、PDF、PNG、TSV） */
                .zoom-controls button[data-action="reset"],
                .zoom-controls button[data-action="export-pdf"],
                .zoom-controls button[data-action="export-png"],
                .zoom-controls button[data-action="export-tsv"] {{
                    font-size: 12px;  /* 較小的字體 */
                    padding: 0;
                }}
                
                /* 按鈕懸停效果 */
                .zoom-controls button:hover {{
                    background: #e9ecef;
                    border-color: #999;
                }}
                
                /* 按鈕按下效果 */
                .zoom-controls button:active {{
                    background: #dee2e6;
                }}
                
                /* -----------------------------------------------
                   Plotly Modebar 樣式（隱藏或調整位置）
                   ----------------------------------------------- */
                #modebarContainer {{
                    margin-top: 10px;
                    display: flex;
                    justify-content: center;
                }}
                #modebarContainer .modebar {{
                    position: relative !important;
                    right: auto !important;
                    left: auto !important;
                    top: auto !important;
                    transform: scale(1.0);
                    transform-origin: center;
                }}
                
                /* -----------------------------------------------
                   Plotly 文字標籤樣式：增加字體間距
                   ----------------------------------------------- */
                /* 針對所有 Plotly SVG 文字元素增加字體間距 */
                .js-plotly-plot svg text {{
                    letter-spacing: 0.5px !important;  /* 增加字體間距 0.5px */
                }}
                
                /* 針對頂部標註標籤（物種、地理、年份）進一步增加間距 */
                .js-plotly-plot svg .xtick text {{
                    letter-spacing: 1px !important;  /* 頂部標註標籤增加 1px 間距 */
                }}
            </style>
            
            <!-- 外部 JavaScript 庫：PDF 匯出功能所需 -->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/pdf-lib/1.17.1/pdf-lib.min.js"></script>
        </head>
        <body>
            <!-- 縮放控制按鈕：固定在右上角 -->
            <div class="zoom-controls" id="zoomControls">
                <button data-action="zoom-in" title="放大">＋</button>
                <button data-action="zoom-out" title="縮小">－</button>
                <button data-action="reset" title="重置">Reset</button>
                <button data-action="export-pdf" title="匯出 PDF">PDF</button>
                <button data-action="export-png" title="匯出 PNG">PNG</button>
                <button data-action="export-tsv" title="匯出摘要 TSV">TSV</button>
            </div>
            
            <!-- 圖表容器：包含圖表包裝器和可滾動的圖表內容 -->
            <div class="chart-container">
                <div class="chart-wrapper">
                    <div class="chart-scroll" id="heatmapScroll">
                    {inner_html}
                    </div>
                </div>
            </div>
            
            <!-- 頁尾：顯示生成信息和圖例說明 -->
            <div class="footer">
                <p>Generated by Python/Plotly | Mimicking ComplexHeatmap Package</p>
                <p>🔵 Species annotation | 🟢 Geographic annotation | 🟠 Year annotation | 🔴 Query sample</p>
            </div>
            
            <!-- Query 行高亮和標籤調整的 JavaScript -->
            {query_highlight_js}
            <script>
            (function() {{
                // ----------------------------------------------
                // 初始化：獲取 DOM 元素並檢查環境
                // ----------------------------------------------
                const scrollBox = document.getElementById('heatmapScroll');
                const zoomControls = document.getElementById('zoomControls');
                if (!scrollBox || !zoomControls) return;
                
                // 檢查連線協議（建議使用 HTTPS）
                if (window.location.protocol !== 'https:') {{
                    console.warn('⚠️ ComplexHeatmap：目前在 HTTP 連線下下載檔案，建議改用 HTTPS 以提升安全性。');
                }}
                
                // 啟用自訂縮放樣式
                scrollBox.classList.add('zoomable');
                zoomControls.classList.add('active');
                
                // -----------------------------------------------
                // 容器尺寸調整和 Modebar 隱藏
                // -----------------------------------------------
                const wrapper = scrollBox.parentElement;
                if (wrapper && wrapper.classList.contains('chart-wrapper')) {{
                    const plotDiv = scrollBox.querySelector('.js-plotly-plot');
                    if (plotDiv) {{
                        // 隱藏 Plotly 的 modebar（使用自訂控制按鈕）
                        function hideModebar() {{
                            const modebar = plotDiv.querySelector('.modebar') || 
                                          scrollBox.querySelector('.modebar') ||
                                          document.querySelector('.modebar');
                            if (modebar) {{
                                modebar.style.display = 'none';
                            }}
                        }}
                        
                        // 動態調整 wrapper 容器尺寸以匹配圖表尺寸
                        function adjustWrapperSize() {{
                            const plotWidth = plotDiv.offsetWidth || plotDiv.clientWidth;
                            const plotHeight = plotDiv.offsetHeight || plotDiv.clientHeight;
                            if (plotWidth > 0 && plotHeight > 0) {{
                                wrapper.style.width = plotWidth + 'px';
                                wrapper.style.height = plotHeight + 'px';
                            }}
                            hideModebar();
                        }}
                        
                        // 監聽 Plotly 圖表載入完成事件
                        plotDiv.on('plotly_afterplot', function() {{
                            adjustWrapperSize();
                        }});
                        
                        // 如果圖表已經載入，立即調整
                        setTimeout(adjustWrapperSize, 100);
                        
                        // 持續監聽 modebar 的出現並隱藏（使用 MutationObserver）
                        const modebarObserver = new MutationObserver(() => {{
                            hideModebar();
                        }});
                        modebarObserver.observe(plotDiv, {{ childList: true, subtree: true }});
                    }}
                }}
                
                // -----------------------------------------------
                // 縮放和位置狀態變數
                // -----------------------------------------------
                let scale = 1;  // 當前縮放比例
                let pos = {{ x: 0, y: 0 }};  // 當前位置（x, y 座標）
                let last = {{ x: 0, y: 0 }};  // 上次滑鼠位置（用於拖曳計算）
                let dragging = false;  // 是否正在拖曳
                
                // -----------------------------------------------
                // 應用變換：將縮放和位置應用到圖表
                // -----------------------------------------------
                function applyTransform() {{
                    // 整張圖表一起移動和縮放
                    scrollBox.style.transform = `translate(${{pos.x}}px, ${{pos.y}}px) scale(${{scale}})`;
                    scrollBox.style.transformOrigin = 'center center';  // 變換原點：中心
                }}
                
                // -----------------------------------------------
                // 計算初始縮放比例和位置
                // -----------------------------------------------
                function calculateInitialScale() {{
                    const plotDiv = scrollBox.querySelector('.js-plotly-plot');
                    if (!plotDiv) return;
                    
                    const plotWidth = plotDiv.offsetWidth || plotDiv.clientWidth;
                    const plotHeight = plotDiv.offsetHeight || plotDiv.clientHeight;
                    if (plotWidth > 0 && plotHeight > 0) {{
                        // 計算視窗可用空間（減去按鈕區域和 padding）
                        const availableWidth = window.innerWidth - 100;  // 減去按鈕和邊距
                        const availableHeight = window.innerHeight - 200;  // 減去 header、footer 和邊距
                        
                        // 計算縮放比例：根據可用空間和圖表尺寸
                        const scaleX = availableWidth / plotWidth;
                        const scaleY = availableHeight / plotHeight;
                        const baseScale = Math.min(scaleX, scaleY);  // 取較小值以確保完整顯示
                        const initialScale = Math.min(baseScale * 1.8, 2.5);  // 放大 1.8 倍，最大不超過 2.5 倍
                        
                        // 計算縮放後的尺寸
                        const scaledWidth = plotWidth * initialScale;
                        const scaledHeight = plotHeight * initialScale;
                        
                        // 計算位置：水平居中，垂直聚焦於標題
                        const containerRect = scrollBox.parentElement.getBoundingClientRect();
                        const centerX = (containerRect.width - scaledWidth) / 2;  // 水平居中
                        
                        // 垂直位置：讓標題在 container 頂部，並向上移動以蓋掉空白區塊
                        // transform-origin 是 'center center'，所以圖表中心在 (pos.x, pos.y)
                        // 標題在圖表頂部，距離中心 scaledHeight/2
                        // 如果標題要在 container 頂部（y=0），則：pos.y - scaledHeight/2 = 0
                        // 所以：pos.y = scaledHeight/2
                        // 相對於 container 中心的位置：centerY = scaledHeight/2 - containerRect.height/2
                        const offsetY = -170;  // 向上移動 170px 蓋掉空白
                        const centerY = scaledHeight / 2 - containerRect.height / 2 + offsetY;
                        
                        // 設置初始縮放和位置
                        scale = initialScale;
                        pos = {{ x: centerX, y: centerY }};
                        applyTransform();
                    }}
                }}
                
                // 在圖表載入後計算初始縮放
                const plotDiv = scrollBox.querySelector('.js-plotly-plot');
                if (plotDiv) {{
                    plotDiv.on('plotly_afterplot', function() {{
                        setTimeout(calculateInitialScale, 100);
                    }});
                    setTimeout(calculateInitialScale, 500);
                }}
                
                // 監聽視窗大小變化，重新計算縮放
                window.addEventListener('resize', function() {{
                    setTimeout(calculateInitialScale, 100);
                }});

                // -----------------------------------------------
                // 匯出功能：圖像獲取和文件下載
                // -----------------------------------------------
                // 獲取 Plotly 圖表的圖像（PNG 格式）
                async function getPlotlyImage(scaleFactor = 1.5) {{
                    const plotDiv =
                        document.querySelector('#heatmapScroll .js-plotly-plot') ||
                        document.querySelector('#scrollBox .js-plotly-plot');
                    if (!plotDiv || typeof Plotly === 'undefined') {{
                        throw new Error('找不到 Plotly 圖表，無法匯出');
                    }}
                    // 使用固定的圖表尺寸，確保與後端 PDF/JPG 匯出一致
                    const exportWidth = Math.round(chartWidth * scaleFactor);
                    const exportHeight = Math.round(chartHeight * scaleFactor);
                    const dataUrl = await Plotly.toImage(plotDiv, {{
                        format: 'png',
                        width: exportWidth,
                        height: exportHeight,
                        scale: 2,
                    }});
                    return {{ dataUrl, width: exportWidth, height: exportHeight }};
                }}

                // 將 Data URL 轉換為 Blob 對象
                async function dataUrlToBlob(dataUrl) {{
                    const response = await fetch(dataUrl);
                    return await response.blob();
                }}
                
                // 下載 Blob 對象為文件
                function downloadBlob(blob, filename) {{
                    const url = URL.createObjectURL(blob);
                    const link = document.createElement('a');
                    link.href = url;
                    link.download = filename;
                    link.style.display = 'none';
                    document.body.appendChild(link);
                    link.click();
                    setTimeout(() => {{
                        document.body.removeChild(link);
                        URL.revokeObjectURL(url);  // 釋放 URL 對象
                    }}, 100);
                }}
                
                // -----------------------------------------------
                // 匯出功能實現：PDF、PNG、TSV
                // -----------------------------------------------
                // PDF 匯出：將圖表轉換為 PNG 後嵌入 PDF 文檔
                async function exportToPDF() {{
                    try {{
                        // 檢查 PDFLib 是否已載入
                        if (!window.PDFLib || !window.PDFLib.PDFDocument) {{
                            throw new Error('PDFLib 尚未載入完成');
                        }}
                        
                        // 獲取圖表圖像（縮放係數 2.5，提升文字標籤清晰度）
                        const exportImage = await getPlotlyImage(2.5);
                        const pngBlob = await dataUrlToBlob(exportImage.dataUrl);
                        const pngBytes = await pngBlob.arrayBuffer();
                        
                        // 創建 PDF 文檔
                        const pdfDoc = await window.PDFLib.PDFDocument.create();
                        const isLandscape = exportImage.width >= exportImage.height;  // 判斷橫向或縱向
                        const pageSize = isLandscape ? [842, 595] : [595, 842];  // A4 尺寸（單位: pt）
                        const page = pdfDoc.addPage(pageSize);
                        const margin = 32;  // 頁邊距

                        // 嵌入 PNG 圖像並計算縮放比例
                        const pngImage = await pdfDoc.embedPng(pngBytes);
                        const availableWidth = pageSize[0] - margin * 2;
                        const availableHeight = pageSize[1] - margin * 2;
                        const scale = Math.min(
                            availableWidth / pngImage.width,
                            availableHeight / pngImage.height,
                            1  // 不放大，只縮小
                        );
                        const drawWidth = pngImage.width * scale;
                        const drawHeight = pngImage.height * scale;

                        // 在頁面中央繪製圖像
                        page.drawImage(pngImage, {{
                            x: (pageSize[0] - drawWidth) / 2,  // 水平居中
                            y: (pageSize[1] - drawHeight) / 2,  // 垂直居中
                            width: drawWidth,
                            height: drawHeight
                        }});

                        // 保存並下載 PDF
                        const pdfBytes = await pdfDoc.save();
                        downloadBlob(new Blob([pdfBytes], {{ type: 'application/pdf' }}), 'ComplexHeatmap_frontend.pdf');
                        console.log('✅ PDF 匯出成功（瀏覽器端重新渲染）');
                    }} catch (error) {{
                        console.error('PDF 匯出失敗:', error);
                        alert('PDF 匯出失敗：' + error.message + '\\n\\n建議：\\n1. 確認瀏覽器是否允許下載\\n2. 檢查控制台以獲取更多詳情');
                    }}
                }}
                
                // PNG 匯出：直接下載圖表圖像
                async function exportToPNG() {{
                    try {{
                        const exportImage = await getPlotlyImage(2.5);  // 縮放係數 2.5，提升文字標籤清晰度
                        const blob = await dataUrlToBlob(exportImage.dataUrl);
                        downloadBlob(blob, 'ComplexHeatmap_frontend.png');
                        console.log('✅ PNG 匯出成功（瀏覽器端重新渲染）');
                    }} catch (error) {{
                        console.error('PNG 匯出失敗:', error);
                        alert('PNG 匯出失敗：' + error.message + '\\n\\n建議：\\n1. 確認瀏覽器是否允許下載\\n2. 檢查控制台以獲取更多詳情');
                    }}
                }}
                
                // TSV 匯出：下載摘要統計資料
                function exportToTSV() {{
                    try {{
                        // 檢查是否有 TSV 資料
                        if (!tsvSummaryData || tsvSummaryData.trim() === '') {{
                            alert('沒有可用的 TSV 摘要資料');
                            return;
                        }}
                        
                        // 創建 Blob 並下載
                        const blob = new Blob([tsvSummaryData], {{ type: 'text/tab-separated-values;charset=utf-8;' }});
                        const link = document.createElement('a');
                        link.href = URL.createObjectURL(blob);
                        link.download = 'heatmap_summary.tsv';
                        link.click();
                        URL.revokeObjectURL(link.href);  // 釋放 URL 對象
                    }} catch (error) {{
                        console.error('TSV 匯出失敗:', error);
                        alert('TSV 匯出失敗，請稍後再試');
                    }}
                }}
                
                // -----------------------------------------------
                // 事件監聽器：按鈕點擊、拖曳、滾輪縮放
                // -----------------------------------------------
                // 縮放控制按鈕事件處理
                document.querySelectorAll('#zoomControls button').forEach(btn => {{
                    btn.addEventListener('click', (e) => {{
                        e.stopPropagation();  // 阻止事件冒泡
                        const action = btn.dataset.action;
                        
                        if (action === 'zoom-in') {{
                            // 放大：每次增加 0.25，最大 3 倍
                            scale = Math.min(scale + 0.25, 3);
                        }} else if (action === 'zoom-out') {{
                            // 縮小：每次減少 0.25，最小 0.5 倍
                            scale = Math.max(scale - 0.25, 0.5);
                        }} else if (action === 'reset') {{
                            // 重置：恢復到初始的居中狀態
                            calculateInitialScale();
                            return;
                        }} else if (action === 'export-pdf') {{
                            // 匯出 PDF
                            exportToPDF();
                            return;
                        }} else if (action === 'export-png') {{
                            // 匯出 PNG
                            exportToPNG();
                            return;
                        }} else if (action === 'export-tsv') {{
                            // 匯出 TSV
                            exportToTSV();
                            return;
                        }}
                        applyTransform();  // 應用變換
                    }});
                }});
                
                // -----------------------------------------------
                // 拖曳功能：整張圖表一起移動
                // -----------------------------------------------
                // 滑鼠按下：開始拖曳
                scrollBox.addEventListener('mousedown', (e) => {{
                    if (e.button !== 0) return;  // 只處理左鍵（button 0）
                    dragging = true;
                    last = {{ x: e.clientX, y: e.clientY }};  // 記錄起始位置
                    scrollBox.classList.add('dragging');  // 添加拖曳樣式
                    e.preventDefault();
                }});
                
                // 滑鼠移動：更新位置
                window.addEventListener('mousemove', (e) => {{
                    if (!dragging) return;
                    const dx = e.clientX - last.x;  // 水平位移
                    const dy = e.clientY - last.y;  // 垂直位移
                    pos.x += dx;  // 更新 x 座標
                    pos.y += dy;  // 更新 y 座標
                    last = {{ x: e.clientX, y: e.clientY }};  // 更新上次位置
                    applyTransform();  // 應用變換
                }});
                
                // 滑鼠放開：結束拖曳
                window.addEventListener('mouseup', () => {{
                    dragging = false;
                    scrollBox.classList.remove('dragging');  // 移除拖曳樣式
                }});
                
                // 防止拖曳時選取文字
                scrollBox.addEventListener('selectstart', (e) => {{
                    if (dragging) e.preventDefault();
                }});
                
                // -----------------------------------------------
                // 滾輪縮放功能
                // -----------------------------------------------
                scrollBox.addEventListener('wheel', (e) => {{
                    e.preventDefault();  // 防止頁面滾動
                    // 向下滾動縮小（deltaY > 0），向上滾動放大（deltaY < 0）
                    const delta = e.deltaY > 0 ? -0.1 : 0.1;
                    scale = Math.max(0.5, Math.min(3, scale + delta));  // 限制在 0.5 到 3 倍之間
                    applyTransform();
                }}, {{ passive: false }});  // passive: false 允許 preventDefault
            }})();
            </script>
        </body>
        </html>
        """
        # 寫入 HTML 文件並匯出靜態圖表
        with open(html_path, "w", encoding="utf-8") as f:
            f.write(wrapped_html)

        # 檢查錯誤用
        print(f"✅ ComplexHeatmap 熱圖已生成：{html_path}")
        print(f"   - 包含 5 個物種標註欄位 (AB, EF, KP, PA, SA)")
        print(f"   - 包含 8 個地理區域標註")
        print(f"   - 包含 22 個年份標註 (2000-2021)")
        if show_main_heatmap:
            print(f"   - 包含 24 種抗生素類別顏色標註")
        else:
            print(f"   - 已隱藏主熱圖（僅保留註解矩陣：物種、地理、年份）")

        # 靜態圖表匯出（PDF 和 JPG 格式，需要安裝 Kaleido）
        pdf_path, jpg_path = self._export_static_images(fig, final_width, final_height)

        # 返回所有生成的文件路徑
        return {"html": html_path, "pdf": pdf_path, "jpg": jpg_path}

    # ========================================================================
    # 混合式熱圖生成：繪製簡化版抗藥性熱圖
    #
    # plot_heatmap_hybrid: 提供專注於抗藥性矩陣的簡化版視覺化
    #
    # 【主要功能】
    #   生成包含以下組件的簡化熱圖：
    #   - 左側階層樹狀圖（dendrogram）：樣本聚類關係
    #   - 右側主熱圖（抗藥性模式）：顯示各樣本的抗藥性模式
    #
    # 【特色功能】
    #   - 移除 Y 軸刻度標籤（適合大量樣本，提升可讀性）
    #   - 支援點擊淡化互動效果（點擊樣本行時淡化其他行）
    #   - 支援自訂縮放與拖曳（與標註熱圖相同的互動功能）
    #
    # 【與 plot_heatmap_with_annotations 的差異】
    #   - 簡化版：不包含物種、地理、年份標註
    #   - 專注於抗藥性模式：更適合快速瀏覽大量樣本
    #   - 更簡潔的視覺化：減少視覺干擾
    # ========================================================================
    def plot_heatmap_hybrid(
        self, df: pd.DataFrame, initial_width: int = None, initial_height: int = None
    ) -> str:
        """生成簡化版的抗藥性熱圖

        包含左側階層樹狀圖和右側主熱圖（抗藥性模式）。

        Args:
            df: 合併後的抗藥性資料表
            initial_width: 初始圖表寬度（像素），None 時自動計算
            initial_height: 初始圖表高度（像素），None 時自動計算

        Returns:
            str: HTML 互動式熱圖路徑
        """
        # ----------------------------------------------------------------------
        # 資料預處理：保存原始 df 用於生成 TSV
        # ----------------------------------------------------------------------
        df_for_tsv = df.copy()
        df = df.set_index("Genome_ID")

        # 檢查抗藥性欄位設定：檢查抗藥性欄位設定，如果抗藥性欄位設定不存在，則返回錯誤
        if not self.profile_columns:
            raise ValueError("尚未設定抗藥性欄位，無法繪製混合式熱圖。")
        profile_cols = [col for col in self.profile_columns if col in df.columns]
        if not profile_cols:
            raise ValueError("合併資料缺少抗藥性欄位，無法繪製混合式熱圖。")

        matrix = df[profile_cols].to_numpy()
        n_rows, n_cols = len(df), len(profile_cols)

        # ----------------------------------------------------------------------
        # 版面尺寸計算：根據樣本數量自動調整格子大小
        # ----------------------------------------------------------------------
        max_cells = max(n_rows, n_cols)  # 計算最大單元數量
        if max_cells > 100:  # 如果最大單元數量大於 100，則設置單元大小為 18
            cell_size = 18  # 設置單元大小為 18
        elif max_cells > 50:  # 如果最大單元數量大於 50，則設置單元大小為 36
            cell_size = 36  # 設置單元大小為 36
        elif max_cells > 30:  # 如果最大單元數量大於 30，則設置單元大小為 54
            cell_size = 54  # 設置單元大小為 54
        else:  # 如果最大單元數量小於等於 30，則設置單元大小為 70
            cell_size = 70  # 設置單元大小為 70

        dendro_width = 400  # 設置階層樹狀圖寬度
        width = dendro_width + n_cols * cell_size
        height = n_rows * cell_size

        # ----------------------------------------------------------------------
        # 階層樹狀圖生成
        # ----------------------------------------------------------------------
        linkage_matrix = sch.linkage(matrix, method="ward")  # 使用 ward 方法進行聚類
        # 生成階層樹狀圖
        dendro = ff.create_dendrogram(
            matrix,
            orientation="left",
            labels=None,
            linkagefun=lambda _: linkage_matrix,  # 使用 linkagefun 設置 linkage 矩陣
        )
        # 翻轉方向
        for trace in dendro["data"]:
            trace["x"] = [-x for x in trace["x"]]  # 翻轉方向
            trace["xaxis"], trace["yaxis"] = "x1", "y2"  # 設置 x 軸和 y 軸

        # 建立主熱圖
        heatmap = go.Heatmap(
            z=matrix,  # 設置 z 值
            x=profile_cols,  # 設置 x 值
            y=df.index,  # 設置 y 值
            colorscale="RdYlGn_r",  # 設置顏色刻度
            colorbar=dict(title="抗藥性值", len=0.75),  # 設置顏色刻度標題和長度
            zsmooth=False,  # 設置 z 平滑
            xgap=2,  # 設置 x 間距
            ygap=2,  # 設置 y 間距
            showscale=True,  # 設置顯示刻度
            hovertemplate="抗生素 %{x}<br>樣本 %{y}<br>值 %{z}<extra></extra>",  # 設置懸停模板
        )

        # ----------------------------------------------------------------------
        # 子圖組合（階層樹 + 主熱圖）
        # ----------------------------------------------------------------------
        fig = make_subplots(
            rows=1,  # 設置行數
            cols=2,  # 設置列數
            column_widths=[
                dendro_width / (dendro_width + n_cols * cell_size),  # 設置列寬
                (n_cols * cell_size) / (dendro_width + n_cols * cell_size),  # 設置列寬
            ],
            specs=[[{"type": "scatter"}, {"type": "heatmap"}]],  # 設置規格
            horizontal_spacing=0.005,  # 設置水平間距
        )
        for trace in dendro["data"]:  # 遍歷階層樹狀圖的所有線段（trace）
            fig.add_trace(trace, row=1, col=1)  # 添加階層樹狀圖
        fig.add_trace(heatmap, row=1, col=2)  # 添加主熱圖

        # HTML 輸出與互動功能設定（自訂縮放控制）
        html_path = os.path.join(
            self.out_path, "Hybrid_AMR_Heatmap.html"
        )  # 設置 HTML 路徑

        # 圖表版面設定（移除 Y 軸刻度標籤）
        fig.update_yaxes(
            matches="y2", autorange="reversed", showticklabels=False
        )  # 設置 y 軸
        fig.update_xaxes(showticklabels=False)  # 設置 x 軸
        fig.update_layout(
            width=width,  # 設置寬度
            height=height,  # 設置高度
            title=f"🧬 Hybrid AMR Heatmap（{n_rows}×{n_cols}）",  # 設置標題
            title_x=0.5,  # 設置標題水平位置
            showlegend=False,  # 設置顯示圖例
            margin=dict(l=30, r=30, t=80, b=40),  # 設置邊距
            paper_bgcolor="white",  # 設置紙張背景顏色
            plot_bgcolor="white",  # 設置圖表背景顏色
            dragmode=False,  # 禁用 Plotly 拖曳，使用自訂控制
            hovermode="closest",  # 設置懸停模式
            xaxis1=dict(showgrid=False, showticklabels=False),  # 設置 x 軸
            yaxis1=dict(showgrid=False, showticklabels=False),  # 設置 y 軸
            xaxis2=dict(showgrid=False),  # 設置 x 軸
            yaxis2=dict(showgrid=False),  # 設置 y 軸
            uirevision="hybrid_heatmap_fixed",  # 設置 ui 版本
        )
        # 固定軸範圍，使用自訂縮放控制
        fig.update_xaxes(
            showspikes=True,  # 設置顯示 spikes
            spikemode="across",  # 設置 spikes 模式
            spikesnap="cursor",  # 設置 spikes 捕捉模式
            spikethickness=1,  # 設置 spikes 厚度
            showline=True,  # 設置顯示線條
            fixedrange=True,  # 設置固定軸範圍
            automargin=True,  # 設置自動邊距
        )
        fig.update_yaxes(
            showspikes=True,
            spikemode="across",  # 設置 spikes 模式
            spikesnap="cursor",  # 設置 spikes 捕捉模式
            spikethickness=1,  # 設置 spikes 厚度
            showline=True,  # 設置顯示線條
            fixedrange=True,  # 設置固定軸範圍
            automargin=True,  # 設置自動邊距
        )

        # ----------------------------------------------------------------------
        # 視覺元素：分隔線
        # ----------------------------------------------------------------------
        fig.add_shape(
            type="line",  # 設置線條類型
            xref="paper",  # 設置 x 軸參考
            yref="paper",  # 設置 y 軸參考
            x0=dendro_width / width,  # 設置 x 起始位置
            x1=dendro_width / width,  # 設置 x 結束位置
            y0=0,  # 設置 y 起始位置
            y1=1,  # 設置 y 結束位置
            line=dict(color="lightgray", width=2),  # 設置線條顏色和寬度
        )

        inner_html = fig.to_html(  # 轉換為 HTML
            include_plotlyjs="cdn",  # 設置 Plotly JS
            full_html=False,  # 設置 full HTML
            config=self._get_plotly_config(),  # 設置 Plotly 配置
        )

        # 生成 TSV 摘要內容
        tsv_content = self._generate_tsv_content(df_for_tsv)

        # ----------------------------------------------------------------------
        # JavaScript 互動功能（點擊淡化 + 指標控制）
        # ----------------------------------------------------------------------
        embedded_js = """
        <script>
        document.addEventListener("DOMContentLoaded", function() {
            // 獲取 Plotly 圖表容器
            const plotDiv = document.querySelector('.js-plotly-plot');
            if (!plotDiv) return;
            
            // 狀態變數：儲存最後點擊的格子索引
            let lastClickedIndex = null; 

            // 點擊淡化效果：點擊格子時淡化其他格子
            plotDiv.on('plotly_click', function(data) {
                if (!data.points || !data.points.length) return; // 如果沒有點擊到格子，則返回
                
                // 獲取點擊位置的座標索引
                const pt = data.points[0];
                const xIdx = pt.pointIndex[0];  // X 軸索引（抗生素列）
                const yIdx = pt.pointIndex[1];  // Y 軸索引（樣本行）

                // 獲取所有熱圖的矩形元素
                const heatRects = plotDiv.querySelectorAll('.hm rect');
                if (!heatRects.length) return;

                // 將所有格子設為半透明（透明度 0.25）
                heatRects.forEach(rect => rect.style.opacity = 0.25);

                // 計算被點擊格子的一維索引
                const nCols = pt.fullData.z[0].length;
                const targetIdx = yIdx * nCols + xIdx; // 計算被點擊格子的一維索引 (行索引 × 列數 + 列索引 = 一維索引)

                // 被點擊的格子恢復完全不透明（透明度 1.0）
                if (heatRects[targetIdx]) {
                    heatRects[targetIdx].style.opacity = 1.0; // 將被點擊格子設為完全不透明
                }

                lastClickedIndex = targetIdx; // 更新最後點擊的格子索引
            });

            // 滑鼠移開恢復：當滑鼠移開圖表時恢復所有格子的透明度
            plotDiv.on('plotly_unhover', function() {
                const heatRects = plotDiv.querySelectorAll('.hm rect');
                // 恢復所有格子的完全不透明狀態
                heatRects.forEach(rect => rect.style.opacity = 1.0);
                // 清除最後點擊的索引記錄
                lastClickedIndex = null;
            });

            // 游標樣式設置：將所有互動元素的游標設為指針
            const style = document.createElement('style');
            style.innerHTML = `
                /* 為所有可互動元素設置指針游標 */
                .nsewdrag,      /* 拖曳元素 */
                .nsdrag,        /* 垂直拖曳 */
                .ewdrag,        /* 水平拖曳 */
                .cursor-crosshair,  /* 十字游標 */
                .hoverlayer,    /* 懸停層 */
                .hm rect {      /* 熱圖矩形 */
                    cursor: pointer !important;
                }
            `;
            document.head.appendChild(style);
        });
        </script>
        """

        # ====================================================================
        # HTML 包裝與 TSV 內容嵌入：生成完整的互動式 HTML 頁面
        # ====================================================================
        # TSV 內容轉義：將 TSV 內容中的特殊字元轉義，以便安全嵌入 JavaScript 模板字串
        # 轉義規則：反斜線、反引號、美元符號需要轉義，避免破壞 JavaScript 語法
        tsv_content_escaped = (
            tsv_content.replace("\\", "\\\\").replace("`", "\\`").replace("$", "\\$")
        )

        # HTML 結構生成：建立完整的互動式 HTML 頁面
        wrapped_html = f"""
        <html>
        <head>
            <meta charset="utf-8">
            <title>Hybrid AMR Heatmap</title>
            <script>
                // 將 TSV 摘要內容嵌入為 JavaScript 變數，供匯出功能使用
                const tsvSummaryData = `{tsv_content_escaped}`;
            </script>
            <style>
                /* ----------------------------------------------------------------------
                   頁面基本樣式：body 和整體佈局
                   ---------------------------------------------------------------------- */
                body {{
                    background-color: #f8f9fa;  /* 淺灰色背景 */
                    font-family: Arial, sans-serif;
                    text-align: center;
                    margin: 0;
                    padding: 0;
                    display: flex;
                    flex-direction: column;  /* 垂直排列 */
                    min-height: 100vh;  /* 最小高度為視窗高度 */
                }}
                
                /* ----------------------------------------------------------------------
                   圖表容器樣式：外層容器和內層滾動區域
                   ---------------------------------------------------------------------- */
                /* 外層容器：居中對齊，從頂部開始排列 */
                .chart-container {{
                    display: flex;
                    justify-content: center;
                    align-items: flex-start;  /* 從頂部開始對齊，而不是居中 */
                    flex: 1;
                    padding: 0 20px 20px 20px;  /* 移除上方 padding，只保留左右和下方 */
                    width: 100%;
                    box-sizing: border-box;
                }}
                
                /* 圖表滾動區域：初始狀態（未啟用縮放時） */
                .chart-scroll {{
                    max-width: 85vw;  /* 最大寬度為視窗寬度的 85% */
                    max-height: 98vh;  /* 最大高度為視窗高度的 98% */
                    overflow: hidden;  /* 移除滾動條，改用拖曳移動 */
                    border: 1px solid #ccc;
                    border-radius: 6px;
                    box-shadow: 0 0 8px rgba(0, 0, 0, 0.12);
                    background-color: #fff;
                    padding: 48px 0 0 0;
                }}
                
                /* 移除 Plotly 元素的預設間距 */
                .chart-scroll .js-plotly-plot, 
                .chart-scroll .plotly, 
                .chart-scroll .plot-container {{
                    margin: 0 !important;
                    padding: 0 !important;
                }}
                .chart-scroll svg {{
                    display: block;
                    margin: 0 !important;
                    padding: 0 !important;
                }}
                
                /* ----------------------------------------------------------------------
                   縮放控制按鈕樣式：固定在右上角的控制面板
                   ---------------------------------------------------------------------- */
                /* 按鈕容器：固定在右上角 */
                .zoom-controls {{
                    position: fixed;
                    top: 60px;
                    right: 20px;
                    background: white;
                    padding: 10px;
                    border-radius: 8px;
                    box-shadow: 0 2px 8px rgba(0,0,0,0.15);
                    z-index: 1001;  /* 確保在圖表上方 */
                    display: block;
                }}
                
                /* 按鈕基本樣式 */
                .zoom-controls button {{
                    display: block;
                    width: 40px;
                    height: 40px;
                    margin: 2px 0;
                    border: 1px solid #ccc;
                    border-radius: 4px;
                    background: #f8f9fa;
                    cursor: pointer;
                    font-size: 18px;
                    font-weight: bold;
                    color: #333;
                    transition: all 0.2s;  /* 平滑過渡效果 */
                }}
                
                /* 文字按鈕（重置、匯出）使用較小的字體 */
                .zoom-controls button[data-action="reset"],
                .zoom-controls button[data-action="export-pdf"],
                .zoom-controls button[data-action="export-png"],
                .zoom-controls button[data-action="export-tsv"] {{
                    font-size: 12px;
                    padding: 0;
                }}
                
                /* 按鈕互動效果 */
                .zoom-controls button:hover {{
                    background: #e9ecef;
                    border-color: #999;
                }}
                .zoom-controls button:active {{
                    background: #dee2e6;
                }}
                
                /* ----------------------------------------------------------------------
                   Plotly Modebar 樣式：隱藏或調整 Plotly 預設工具列
                   ---------------------------------------------------------------------- */
                /* Modebar 容器：居中顯示 */
                #modebarContainer, #modebarContainerHybrid {{
                    margin-top: 10px;
                    display: flex;
                    justify-content: center;
                }}
                /* Modebar 本身：相對定位，不固定在右上角 */
                #modebarContainer .modebar, 
                #modebarContainerHybrid .modebar {{
                    position: relative !important;
                    right: auto !important;
                    left: auto !important;
                    top: auto !important;
                    transform: scale(1.0);
                    transform-origin: center;
                }}
                
                /* ----------------------------------------------------------------------
                   圖表包裝器樣式：作為視窗容器，隱藏滾動條
                   ---------------------------------------------------------------------- */
                /* 圖表包裝器：作為視窗，限制可見區域 */
                .chart-wrapper {{
                    display: inline-block;
                    max-width: 85vw;
                    max-height: 98vh;
                    overflow: hidden;  /* 隱藏超出部分 */
                    position: relative;
                    border: 1px solid #ccc;
                    border-radius: 6px;
                    box-shadow: 0 0 8px rgba(0, 0, 0, 0.12);
                    background-color: #fff;
                }}
                
                /* 可縮放的圖表滾動區域：啟用縮放和拖曳功能 */
                .chart-scroll.zoomable {{
                    transform-origin: top left;  /* 縮放原點在左上角 */
                    cursor: grab;  /* 游標顯示為抓取手勢 */
                    transition: transform 0.1s ease-out;  /* 平滑的變換效果 */
                    overflow: visible;  /* 允許內容超出容器 */
                    border: none;  /* 移除邊框 */
                    border-radius: 0;
                    box-shadow: none;
                    background-color: transparent;
                    padding-top: 0;
                    width: fit-content;  /* 寬度適應內容 */
                    height: fit-content;  /* 高度適應內容 */
                }}
                
                /* 拖曳中的狀態：游標變為抓取中 */
                .chart-scroll.zoomable.dragging {{
                    cursor: grabbing;
                    transition: none;  /* 拖曳時禁用過渡效果 */
                }}
                
                /* ----------------------------------------------------------------------
                   Plotly 文字標籤樣式：增加字體間距
                   ---------------------------------------------------------------------- */
                /* 針對所有 Plotly SVG 文字元素增加字體間距 */
                .js-plotly-plot svg text {{
                    letter-spacing: 0.5px !important;  /* 增加字體間距 0.5px */
                }}
                
                /* 針對頂部標註標籤（物種、地理、年份）進一步增加間距 */
                .js-plotly-plot svg .xtick text {{
                    letter-spacing: 1px !important;  /* 頂部標註標籤增加 1px 間距 */
                }}
            </style>
            
            <!-- ----------------------------------------------------------------------
                 外部資源載入：PDF 匯出所需的 JavaScript 庫
                 ---------------------------------------------------------------------- -->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/pdf-lib/1.17.1/pdf-lib.min.js"></script>
        </head>
        <body>
            <!-- -----------------------------------------------
                 縮放控制按鈕：固定在右上角的控制面板
                 ----------------------------------------------- -->
            <div class="zoom-controls" id="zoomControlsHybrid">
                <button data-action="zoom-in" title="放大">＋</button>
                <button data-action="zoom-out" title="縮小">－</button>
                <button data-action="reset" title="重置">⌂</button>
                <button data-action="export-pdf" title="匯出 PDF">PDF</button>
                <button data-action="export-png" title="匯出 PNG">PNG</button>
                <button data-action="export-tsv" title="匯出摘要 TSV">TSV</button>
            </div>
            
            <!-- -----------------------------------------------
                 圖表容器：包含 Plotly 圖表的可縮放區域
                 ----------------------------------------------- -->
            <div class="chart-container">
                <div class="chart-wrapper">
                    <div class="chart-scroll" id="scrollBox">
                        {inner_html}
                    </div>
                </div>
            </div>
            
            <!-- -----------------------------------------------
                 點擊淡化互動功能：嵌入的 JavaScript 代碼
                 ----------------------------------------------- -->
            {embedded_js}
            <script>
            (function() {{
                // -----------------------------------------------
                // 初始化：獲取 DOM 元素並檢查環境
                // -----------------------------------------------
                const scrollBox = document.getElementById('scrollBox');
                const zoomControls = document.getElementById('zoomControlsHybrid');
                if (!scrollBox || !zoomControls) return;
                
                // 安全性警告：HTTP 連線下的檔案下載警告
                if (window.location.protocol !== 'https:') {{
                    console.warn('⚠️ ComplexHeatmap Hybrid：目前在 HTTP 連線下下載檔案，建議改用 HTTPS 以提升安全性。');
                }}
                
                // 啟用自訂縮放樣式
                scrollBox.classList.add('zoomable');
                zoomControls.classList.add('active');
                
                // -----------------------------------------------
                // 容器尺寸調整：動態調整 wrapper 尺寸以匹配圖表
                // -----------------------------------------------
                const wrapper = scrollBox.parentElement;
                if (wrapper && wrapper.classList.contains('chart-wrapper')) {{
                    const plotDiv = scrollBox.querySelector('.js-plotly-plot');
                    if (plotDiv) {{
                        // 隱藏 Plotly 的 modebar（預設工具列）
                        function hideModebar() {{
                            const modebar = plotDiv.querySelector('.modebar') || 
                                          scrollBox.querySelector('.modebar') ||
                                          document.querySelector('.modebar');
                            if (modebar) {{
                                modebar.style.display = 'none';
                            }}
                        }}
                        
                        // 監聽 Plotly 圖表載入完成事件，調整容器尺寸
                        plotDiv.on('plotly_afterplot', function() {{
                            const plotWidth = plotDiv.offsetWidth || plotDiv.clientWidth;
                            const plotHeight = plotDiv.offsetHeight || plotDiv.clientHeight;
                            if (plotWidth > 0 && plotHeight > 0) {{
                                wrapper.style.width = plotWidth + 'px';
                                wrapper.style.height = plotHeight + 'px';
                            }}
                            hideModebar();
                        }});
                        
                        // 如果圖表已經載入，立即調整（備用方案）
                        setTimeout(() => {{
                            const plotWidth = plotDiv.offsetWidth || plotDiv.clientWidth;
                            const plotHeight = plotDiv.offsetHeight || plotDiv.clientHeight;
                            if (plotWidth > 0 && plotHeight > 0) {{
                                wrapper.style.width = plotWidth + 'px';
                                wrapper.style.height = plotHeight + 'px';
                            }}
                            hideModebar();
                        }}, 100);
                        
                        // 持續監聽 modebar 的出現並隱藏（防止動態生成）
                        const modebarObserver = new MutationObserver(() => {{
                            hideModebar();
                        }});
                        modebarObserver.observe(plotDiv, {{ childList: true, subtree: true }});
                    }}
                }}
                
                // -----------------------------------------------
                // 縮放和位置狀態變數
                // -----------------------------------------------
                let scale = 1;  // 當前縮放比例
                let pos = {{ x: 0, y: 0 }};  // 當前位置（x, y 座標）
                let last = {{ x: 0, y: 0 }};  // 上次滑鼠位置（用於拖曳計算）
                let dragging = false;  // 是否正在拖曳
                
                // -----------------------------------------------
                // 變換應用函數：將縮放和位置應用到圖表
                // -----------------------------------------------
                function applyTransform() {{
                    // 整張圖表一起移動和縮放
                    // translate: 移動位置，scale: 縮放比例
                    scrollBox.style.transform = `translate(${{pos.x}}px, ${{pos.y}}px) scale(${{scale}})`;
                    scrollBox.style.transformOrigin = 'center center';  // 縮放原點在中心
                }}
                
                // -----------------------------------------------
                // 初始縮放計算：計算初始縮放比例和位置，使圖表完整顯示並居中
                // -----------------------------------------------
                function calculateInitialScale() {{
                    const plotDiv = scrollBox.querySelector('.js-plotly-plot');
                    if (!plotDiv) return;
                    
                    const plotWidth = plotDiv.offsetWidth || plotDiv.clientWidth;
                    const plotHeight = plotDiv.offsetHeight || plotDiv.clientHeight;
                    if (plotWidth > 0 && plotHeight > 0) {{
                        // 計算視窗可用空間（減去按鈕區域和 padding）
                        const availableWidth = window.innerWidth - 100;  // 減去按鈕和邊距
                        const availableHeight = window.innerHeight - 200;  // 減去 header、footer 和邊距
                        
                        // 計算縮放比例，允許放大（放大1.3倍）
                        const scaleX = availableWidth / plotWidth;
                        const scaleY = availableHeight / plotHeight;
                        const baseScale = Math.min(scaleX, scaleY);  // 取較小值以確保完整顯示
                        const initialScale = Math.min(baseScale * 1.3, 2);  // 放大1.3倍，最大不超過2倍
                        
                        // 計算縮放後的尺寸
                        const scaledWidth = plotWidth * initialScale;
                        const scaledHeight = plotHeight * initialScale;
                        
                        // 計算位置：水平居中，垂直聚焦於標題
                        const containerRect = scrollBox.parentElement.getBoundingClientRect();
                        const centerX = (containerRect.width - scaledWidth) / 2;  // 水平居中
                        
                        // 垂直位置計算：讓標題在 container 頂部，並向上移動以蓋掉空白區塊
                        // 由於 transform-origin 是 'center center'，圖表中心在 (pos.x, pos.y)
                        // 標題在圖表頂部，距離中心 scaledHeight/2
                        // 如果標題要在 container 頂部（y=0），則：pos.y - scaledHeight/2 = 0
                        // 所以：pos.y = scaledHeight/2
                        // 相對於 container 中心的位置：centerY = scaledHeight/2 - containerRect.height/2
                        // 進一步向上移動以蓋掉空白區塊（負值表示向上移動）
                        const offsetY = -30;  // 向上移動 30px 以蓋掉空白
                        const centerY = scaledHeight / 2 - containerRect.height / 2 + offsetY;
                        
                        // 設置初始縮放和位置
                        scale = initialScale;
                        pos = {{ x: centerX, y: centerY }};
                        applyTransform();
                    }}
                }}
                
                // 在圖表載入後計算初始縮放
                const plotDiv = scrollBox.querySelector('.js-plotly-plot');
                if (plotDiv) {{
                    plotDiv.on('plotly_afterplot', function() {{
                        setTimeout(calculateInitialScale, 100);
                    }});
                    setTimeout(calculateInitialScale, 500);  // 備用延遲計算
                }}
                
                // 監聽視窗大小變化，重新計算縮放
                window.addEventListener('resize', function() {{
                    setTimeout(calculateInitialScale, 100);
                }});
                
                // -----------------------------------------------
                // 匯出功能：PDF、PNG、TSV 匯出
                // -----------------------------------------------
                // 圖表尺寸：用於匯出功能（從 Python 變數獲取，如果無法獲取則使用 DOM 元素尺寸）
                const plotDivForExport = scrollBox.querySelector('.js-plotly-plot');
                const chartWidth = plotDivForExport ? (plotDivForExport.offsetWidth || plotDivForExport.clientWidth || {width}) : {width};
                const chartHeight = plotDivForExport ? (plotDivForExport.offsetHeight || plotDivForExport.clientHeight || {height}) : {height};
                
                // 獲取 Plotly 圖表的圖像（PNG 格式）
                async function getPlotlyImage(scaleFactor = 2.5) {{
                    const plotDiv =
                        document.querySelector('#heatmapScroll .js-plotly-plot') ||
                        document.querySelector('#scrollBox .js-plotly-plot');
                    if (!plotDiv || typeof Plotly === 'undefined') {{
                        throw new Error('找不到 Plotly 圖表，無法匯出');
                    }}
                    // 使用圖表尺寸計算匯出尺寸
                    const exportWidth = Math.round(chartWidth * scaleFactor);
                    const exportHeight = Math.round(chartHeight * scaleFactor);
                    const dataUrl = await Plotly.toImage(plotDiv, {{
                        format: 'png',
                        width: exportWidth,
                        height: exportHeight,
                        scale: 2,
                    }});
                    return {{ dataUrl, width: exportWidth, height: exportHeight }};
                }}

                // 將 Data URL 轉換為 Blob 對象
                async function dataUrlToBlob(dataUrl) {{
                    const response = await fetch(dataUrl);
                    return await response.blob();
                }}
                
                // 下載 Blob 對象為文件
                function downloadBlob(blob, filename) {{
                    const url = URL.createObjectURL(blob);
                    const link = document.createElement('a');
                    link.href = url;
                    link.download = filename;
                    link.style.display = 'none';
                    document.body.appendChild(link);
                    link.click();
                    setTimeout(() => {{
                        document.body.removeChild(link);
                        URL.revokeObjectURL(url);  // 釋放 URL 對象
                    }}, 100);
                }}
                
                // PDF 匯出功能：將圖表轉換為高解析度 PNG，然後嵌入 PDF
                async function exportToPDF() {{
                    try {{
                        if (!window.PDFLib || !window.PDFLib.PDFDocument) {{
                            throw new Error('PDFLib 尚未載入完成');
                        }}

                        // 獲取高解析度圖表圖片（2.5倍解析度，提升文字標籤清晰度）
                        const exportImage = await getPlotlyImage(2.5);
                        const pngBlob = await dataUrlToBlob(exportImage.dataUrl);
                        const pngBytes = await pngBlob.arrayBuffer();
                        
                        // 創建 PDF 文件
                        const pdfDoc = await window.PDFLib.PDFDocument.create();

                        // 根據圖表方向選擇頁面尺寸（橫向或直向）
                        const isLandscape = exportImage.width >= exportImage.height;
                        const pageSize = isLandscape ? [842, 595] : [595, 842];  // A4 尺寸（像素）
                        const page = pdfDoc.addPage(pageSize);
                        const margin = 32;  // 頁面邊距

                        // 嵌入 PNG 圖片並計算縮放比例
                        const pngImage = await pdfDoc.embedPng(pngBytes);
                        const availableWidth = pageSize[0] - margin * 2;
                        const availableHeight = pageSize[1] - margin * 2;
                        const scale = Math.min(
                            availableWidth / pngImage.width,
                            availableHeight / pngImage.height,
                            1  // 不放大，只縮小
                        );
                        const drawWidth = pngImage.width * scale;
                        const drawHeight = pngImage.height * scale;

                        // 在頁面中央繪製圖片
                        page.drawImage(pngImage, {{
                            x: (pageSize[0] - drawWidth) / 2,
                            y: (pageSize[1] - drawHeight) / 2,
                            width: drawWidth,
                            height: drawHeight
                        }});

                        // 儲存並下載 PDF
                        const pdfBytes = await pdfDoc.save();
                        downloadBlob(new Blob([pdfBytes], {{ type: 'application/pdf' }}), 'ComplexHeatmap_frontend.pdf');
                        console.log('✅ PDF 匯出成功（瀏覽器端重新渲染）');
                    }} catch (error) {{
                        console.error('PDF 匯出失敗:', error);
                        alert('PDF 匯出失敗：' + error.message + '\\n\\n建議：\\n1. 確認瀏覽器是否允許下載\\n2. 檢查控制台以獲取更多詳情');
                    }}
                }}
                
                // PNG 匯出功能：將圖表轉換為高解析度 PNG 圖片
                async function exportToPNG() {{
                    try {{
                        // 獲取高解析度圖表圖片（2.5倍解析度，提升文字標籤清晰度）
                        const exportImage = await getPlotlyImage(2.5);
                        const blob = await dataUrlToBlob(exportImage.dataUrl);
                        downloadBlob(blob, 'ComplexHeatmap_frontend.png');
                        console.log('✅ PNG 匯出成功（瀏覽器端重新渲染）');
                    }} catch (error) {{
                        console.error('PNG 匯出失敗:', error);
                        alert('PNG 匯出失敗：' + error.message + '\\n\\n建議：\\n1. 確認瀏覽器是否允許下載\\n2. 檢查控制台以獲取更多詳情');
                    }}
                }}
                
                // TSV 匯出功能：下載 TSV 摘要資料
                function exportToTSV() {{
                    try {{
                        if (!tsvSummaryData || tsvSummaryData.trim() === '') {{
                            alert('沒有可用的 TSV 摘要資料');
                            return;
                        }}
                        
                        // 創建 Blob 並觸發下載
                        const blob = new Blob([tsvSummaryData], {{ type: 'text/tab-separated-values;charset=utf-8;' }});
                        const link = document.createElement('a');
                        link.href = URL.createObjectURL(blob);
                        link.download = 'heatmap_summary.tsv';
                        link.click();
                        URL.revokeObjectURL(link.href);  // 釋放記憶體
                    }} catch (error) {{
                        console.error('TSV 匯出失敗:', error);
                        alert('TSV 匯出失敗，請稍後再試');
                    }}
                }}
                
                // -----------------------------------------------
                // 縮放控制按鈕事件處理
                // -----------------------------------------------
                document.querySelectorAll('#zoomControlsHybrid button').forEach(btn => {{
                    btn.addEventListener('click', (e) => {{
                        e.stopPropagation();  // 防止事件冒泡
                        const action = btn.dataset.action;
                        
                        if (action === 'zoom-in') {{
                            // 放大：增加 0.25，最大 3 倍
                            scale = Math.min(scale + 0.25, 3);
                        }} else if (action === 'zoom-out') {{
                            // 縮小：減少 0.25，最小 0.5 倍
                            scale = Math.max(scale - 0.25, 0.5);
                        }} else if (action === 'reset') {{
                            // 重置：恢復到初始縮放和位置
                            calculateInitialScale();
                            return;
                        }} else if (action === 'export-pdf') {{
                            exportToPDF();
                            return;
                        }} else if (action === 'export-png') {{
                            exportToPNG();
                            return;
                        }} else if (action === 'export-tsv') {{
                            exportToTSV();
                            return;
                        }}
                        applyTransform();  // 應用變換
                    }});
                }});
                
                // -----------------------------------------------
                // 拖曳功能：整張圖表一起移動
                // -----------------------------------------------
                // 滑鼠按下：開始拖曳
                scrollBox.addEventListener('mousedown', (e) => {{
                    if (e.button !== 0) return;  // 只處理左鍵
                    dragging = true;
                    last = {{ x: e.clientX, y: e.clientY }};  // 記錄起始位置
                    scrollBox.classList.add('dragging');  // 添加拖曳樣式
                    e.preventDefault();
                }});
                
                // 滑鼠移動：更新位置
                window.addEventListener('mousemove', (e) => {{
                    if (!dragging) return;
                    const dx = e.clientX - last.x;  // 計算 X 軸位移
                    const dy = e.clientY - last.y;  // 計算 Y 軸位移
                    pos.x += dx;  // 更新 X 位置
                    pos.y += dy;  // 更新 Y 位置
                    last = {{ x: e.clientX, y: e.clientY }};  // 更新上次位置
                    applyTransform();  // 應用變換
                }});
                
                // 滑鼠放開：結束拖曳
                window.addEventListener('mouseup', () => {{
                    dragging = false;
                    scrollBox.classList.remove('dragging');  // 移除拖曳樣式
                }});
                
                // 防止拖曳時選取文字
                scrollBox.addEventListener('selectstart', (e) => {{
                    if (dragging) e.preventDefault();
                }});
                
                // -----------------------------------------------
                // 滑鼠滾輪縮放功能
                // -----------------------------------------------
                scrollBox.addEventListener('wheel', (e) => {{
                    e.preventDefault();  // 防止頁面滾動
                    // 向下滾動縮小，向上滾動放大
                    const delta = e.deltaY > 0 ? -0.1 : 0.1;
                    scale = Math.max(0.5, Math.min(3, scale + delta));  // 限制在 0.5-3 倍之間
                    applyTransform();
                }}, {{ passive: false }});  // passive: false 允許 preventDefault
            }})();
            </script>
        </body>
        </html>
        """

        # ----------------------------------------------------------------------
        # 文件寫入：將完整的 HTML 內容寫入文件
        # ----------------------------------------------------------------------
        with open(html_path, "w", encoding="utf-8") as f:
            f.write(wrapped_html)

        print(f"✅ Hybrid 熱圖完成（互動淡化 + 尖頭指標）：{html_path}")
        return html_path

    # ========================================================================
    # 主流程控制：串接資料載入、預處理、合併與繪圖步驟
    #
    # run: 統一回傳 HTML、PDF、JPG 與摘要檔案路徑
    #
    # 【主要功能】
    #   執行完整的熱圖生成流程，包括：
    #   - 資料載入：載入抗藥性資料、樣本資訊、物種、國家資料
    #   - 資料預處理：執行 one-hot encoding 轉換
    #   - 資料合併：合併抗藥性資料和樣本資訊
    #   - 熱圖生成：生成簡化版和標註版熱圖
    #   - 摘要輸出：生成統計摘要檔案
    #
    # 【處理流程】
    #   1. 載入資料（抗藥性資料、樣本資訊、物種、國家）
    #   2. 資料預處理（one-hot encoding）
    #   3. 資料合併
    #   4. 生成簡化版熱圖（plot_heatmap_hybrid）
    #   5. 生成標註版熱圖（plot_heatmap_with_annotations，可選）
    #   6. 生成摘要統計檔案（generate_summary）
    # ========================================================================
    def run(
        self,
        with_annotations: bool = True,
        show_main_heatmap: bool = True,
        initial_width: int = None,
        initial_height: int = None,
    ) -> ty.Dict[str, str]:
        """執行完整的熱圖生成流程

        串接資料載入、預處理、合併與繪圖步驟，統一回傳所有輸出檔案路徑。

        Args:
            with_annotations: 是否輸出帶標註的 Plotly 熱圖（保留參數以維持相容性）
            show_main_heatmap: 帶標註熱圖是否顯示主熱圖（False 時僅保留註解視圖）
            initial_width: 初始圖表寬度（像素），None 時使用函數默認值
            initial_height: 初始圖表高度（像素），None 時使用函數默認值

        Returns:
            Dict[str, str]: 包含以下鍵值的字典
                - html: 主要 HTML 熱圖路徑（簡化版）
                - html_annotated: 標註版 HTML 熱圖路徑
                - pdf_annotated: 標註版 PDF 路徑
                - jpg_annotated: 標註版 JPG 路徑
                - summary: 摘要統計檔案路徑
                - output_dir: Python 輸出目錄
                - r_output_dir: R 輸出目錄（此版本為空字串）
        """
        # ----------------------------------------------------------------------
        # 步驟 1：資料載入
        # ----------------------------------------------------------------------
        data = self.load_data()

        # 檢查必要資料是否存在
        if data["profile"].empty:
            print("[錯誤] 缺少必要資料，停止執行。")
            return {
                "html": "",
                "html_annotated": "",
                "pdf_annotated": "",
                "jpg_annotated": "",
                "summary": "",
                "output_dir": self.out_path,
                "r_output_dir": "",
            }

        # 設定抗藥性欄位：排除 Genome_ID 欄位，保留所有抗藥性欄位
        self.profile_columns = [
            col for col in data["profile"].columns if col != "Genome_ID"
        ]

        # ----------------------------------------------------------------------
        # 步驟 2：資料預處理與合併
        # ----------------------------------------------------------------------
        # 預處理表格資料：執行 one-hot encoding 轉換
        table = self.preprocess_table(data["table"], data["species"], data["country"])

        # 合併抗藥性資料和樣本資訊
        merged = self.merge_data(data["profile"], table)

        # 檢查合併後的資料是否為空
        if merged.empty:
            print("[WARN] 合併後資料為空，無法生成熱圖或 summary。回傳空結果。")
            return {
                "html": "",
                "html_annotated": "",
                "pdf_annotated": "",
                "jpg_annotated": "",
                "summary": "",
                "output_dir": self.out_path,
                "r_output_dir": "",
            }

        # ----------------------------------------------------------------------
        # 步驟 3：生成簡化版熱圖（混合式熱圖）
        # ----------------------------------------------------------------------
        html_path = self.plot_heatmap_hybrid(
            merged, initial_width=initial_width, initial_height=initial_height
        )

        # ----------------------------------------------------------------------
        # 步驟 4：生成帶註解的熱圖（可選）
        # ----------------------------------------------------------------------
        # 初始化標註版熱圖路徑
        html_annotated_path = ""
        pdf_annotated_path = ""
        jpg_annotated_path = ""

        # 判斷是否需要生成帶註解的熱圖
        # 為維持過去行為，當 show_main_heatmap=False 時仍會生成帶註解版本
        generate_annotations = with_annotations or (not show_main_heatmap)

        if generate_annotations:
            annotated_result = self.plot_heatmap_with_annotations(
                merged,
                show_main_heatmap=show_main_heatmap,
                initial_width=initial_width,
                initial_height=initial_height,
            )

            # 處理返回結果：可能是字典（包含 html、pdf、jpg）或字串（僅 html 路徑）
            if isinstance(annotated_result, dict):
                # 從字典中獲取各格式的路徑
                html_annotated_path = annotated_result.get("html", "")
                pdf_annotated_path = annotated_result.get("pdf", "")
                jpg_annotated_path = annotated_result.get("jpg", "")
            else:
                # 如果返回的是字串，則僅設置 HTML 路徑
                html_annotated_path = annotated_result

        # ----------------------------------------------------------------------
        # 步驟 5：生成摘要統計檔案
        # ----------------------------------------------------------------------
        summary_path = self.generate_summary(merged)

        # ----------------------------------------------------------------------
        # 步驟 6：返回結果
        # ----------------------------------------------------------------------
        return {
            "html": html_path,
            "html_annotated": html_annotated_path,
            "pdf_annotated": pdf_annotated_path,
            "jpg_annotated": jpg_annotated_path,
            "summary": summary_path,
            "output_dir": self.out_path,
            "r_output_dir": "",
        }
