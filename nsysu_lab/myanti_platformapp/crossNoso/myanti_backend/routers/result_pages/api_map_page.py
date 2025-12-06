import os
import json
import typing as ty
from pathlib import Path
from fastapi import HTTPException

# 任務資料夾根目錄
# 調整 BASE_DIR 取得 myanti_backend 根目錄（向上三層：result_pages -> routers -> myanti_backend）
BASE_DIR = Path(__file__).resolve().parent.parent.parent
BASE_FOLDER = str(BASE_DIR / "anti_form_jobs")


def load_map_data(
    job_id: str,
    base_folder: str = None,
) -> ty.Tuple[ty.Dict[str, ty.Any], ty.List[float], ty.List[str]]:
    """
    讀取並組裝熱圖所需的 GeoJSON 資料與指定國家標記座標。

    Args:
        job_id (str): 任務 ID，對應資料夾名稱。
        base_folder (str, optional): 基礎資料夾路徑，默認使用 BASE_FOLDER。

    Returns:
        def load_map_data(
            job_id: str,
            base_folder: str = None,
        ) -> ty.Tuple[ty.Dict[str, ty.Any], ty.List[float], str, str]:

    Raises:
        HTTPException: 若任何檔案不存在或格式錯誤，則回傳 404 或 500 錯誤。
    """
    # 使用傳入的 base_folder 或默認的 BASE_FOLDER
    folder_path = base_folder if base_folder is not None else BASE_FOLDER

    # 1. 只讀取 formData.json 的 country 欄位
    form_path = os.path.join(folder_path, job_id, "formData.json")
    marker_country = None
    location = None
    if os.path.isfile(form_path):
        try:
            with open(form_path, "r", encoding="utf-8") as f:
                form_data = json.load(f)
                location = form_data.get("location", None)
                if location:
                    marker_country = location.replace(" ", "_")
                else:
                    marker_country = "USA"
                print(f"Map: Processing country - {marker_country}")
        except Exception as e:
            print(f"formData.json parse error: {e}")
            marker_country = "USA"
    else:
        print(f"formData.json not found, default to USA")
        marker_country = "USA"
    countries = [marker_country]
    # Debug log removed

    # 2. 讀取經緯度對照表
    latlon_path = os.path.join(os.path.dirname(__file__), "z_lati_long.tsv")
    if not os.path.isfile(latlon_path):
        raise HTTPException(
            status_code=500, detail="Latitude/Longitude reference not found"
        )
    latitude: ty.Dict[str, float] = {}
    longitude: ty.Dict[str, float] = {}
    with open(latlon_path, "r", encoding="utf-8") as f:
        for idx, line in enumerate(f):
            if idx == 0:
                continue  # 跳過標題列（若有）
            parts = line.strip().split("\t")
            if len(parts) < 3:
                continue
            code, lat_str, lon_str = parts[0], parts[1], parts[2]
            latitude[code] = float(lat_str)
            longitude[code] = float(lon_str)

    # 3. 讀取各國命中數統計
    summary_path = os.path.join(
        folder_path, job_id, "3.abProfilesCmp", "hits_summary.tsv"
    )
    if not os.path.isfile(summary_path):
        raise HTTPException(status_code=404, detail="Hits summary not found")
    hits_sum: ty.Dict[str, int] = {}
    hits_detail: ty.Dict[str, ty.Dict[str, int]] = {}
    with open(summary_path, "r", encoding="utf-8") as f:
        for idx, line in enumerate(f):
            if idx == 0:
                continue
            parts = line.strip().split("\t")
            if len(parts) <= 6:
                continue
            code = parts[0]
            ab = int(parts[1])
            ef = int(parts[2])
            kp = int(parts[3])
            pa = int(parts[4])
            sa = int(parts[5])
            count = int(parts[6])
            hits_sum[code] = count
            hits_detail[code] = {
                "AB": ab,
                "EF": ef,
                "KP": kp,
                "PA": pa,
                "SA": sa,
                "total": count,
            }

    # 4. 讀取詳細菌株表，組裝 GeoJSON Features
    # 優化：直接使用 hits_sum 和 hits_detail，不需要讀取整個 hits_table.tsv
    # 因為我們只需要每個國家的統計資料，而不是每個菌株的詳細資料
    features: ty.List[ty.Dict[str, ty.Any]] = []
    processed_countries = set()  # 避免重複處理相同國家
    pie_chart_labels = [
        "A.baumannii",
        "E.faecium",
        "K.pneumoniae",
        "P.aeruginosa",
        "S.aureus",
    ]
    
    # 直接從 hits_sum 和 hits_detail 建立 features，避免讀取大型 hits_table.tsv
    for country_code in hits_sum.keys():
        # 跳過無座標資訊的國家
        if country_code not in latitude or country_code not in longitude:
            continue
        
        # 跳過已處理的國家
        if country_code in processed_countries:
            continue
        
        # 標記已處理
        processed_countries.add(country_code)

        # 建立標準 GeoJSON Feature，並加入 pie_chart_data（五菌種原始數值）
        ab = hits_detail.get(country_code, {}).get("AB", 0)
        ef = hits_detail.get(country_code, {}).get("EF", 0)
        kp = hits_detail.get(country_code, {}).get("KP", 0)
        pa = hits_detail.get(country_code, {}).get("PA", 0)
        sa = hits_detail.get(country_code, {}).get("SA", 0)
        
        feature = {
            "type": "Feature",
            "geometry": {
                "type": "Point",
                "coordinates": [longitude[country_code], latitude[country_code]],
            },
            "properties": {
                "title": country_code,
                "country": country_code,
                "magnitude": hits_sum.get(country_code, 0),
                "AB": ab,
                "EF": ef,
                "KP": kp,
                "PA": pa,
                "SA": sa,
                "pie_chart_data": [
                    [pie_chart_labels[0], ab],
                    [pie_chart_labels[1], ef],
                    [pie_chart_labels[2], kp],
                    [pie_chart_labels[3], pa],
                    [pie_chart_labels[4], sa],
                ],
            },
        }
        features.append(feature)

    # 5. 建立標準 GeoJSON FeatureCollection
    geojson: ty.Dict[str, ty.Any] = {
        "type": "FeatureCollection",
        "features": features,
    }

    # 6. 建立紅色標記座標
    if marker_country not in latitude or marker_country not in longitude:
        # 若座標不存在，預設世界中心點
        marker = [0.0, 0.0]
    else:
        marker = [longitude[marker_country], latitude[marker_country]]

    # 7.圓餅圖資料，根據 summary_path 以 marker_country 為篩選條件
    pie_chart_labels = [
        "A.baumannii",
        "E.faecium",
        "K.pneumoniae",
        "P.aeruginosa",
        "S.aureus",
    ]
    pie_chart_data = []
    try:
        found = False
        with open(summary_path, "r", encoding="utf-8") as file:
            lines = list(file)

            def clean_country(s):
                return s.strip().replace("\u200b", "").replace("\ufeff", "").lower()

            # 先找指定國家
            for idx, line in enumerate(lines):
                if idx == 0:
                    continue  # 跳過標題列
                parts = line.strip().split("\t")
                if len(parts) < 6:
                    continue  # 跳過格式不正確的行
                # Debug log removed
                if clean_country(parts[0]) == clean_country(marker_country):
                    pie_chart_data = [
                        [pie_chart_labels[0], int(parts[1])],
                        [pie_chart_labels[1], int(parts[2])],
                        [pie_chart_labels[2], int(parts[3])],
                        [pie_chart_labels[3], int(parts[4])],
                        [pie_chart_labels[4], int(parts[5])],
                    ]
                    found = True
                    break
            # fallback: 如果沒找到，嘗試找 USA
            if not found:
                for idx, line in enumerate(lines):
                    if idx == 0:
                        continue
                    parts = line.strip().split("\t")
                    if len(parts) < 6:
                        continue
                    if clean_country(parts[0]) == "usa":
                        pie_chart_data = [
                            [pie_chart_labels[0], int(parts[1])],
                            [pie_chart_labels[1], int(parts[2])],
                            [pie_chart_labels[2], int(parts[3])],
                            [pie_chart_labels[3], int(parts[4])],
                            [pie_chart_labels[4], int(parts[5])],
                        ]
                        found = True
                        # Debug log removed
                        break
            if not found:
                raise HTTPException(status_code=404, detail="找不到國家")
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error processing file: {str(e)}")

    return (geojson, marker, marker_country, pie_chart_data)
