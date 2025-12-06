#!/usr/bin/env Rscript

# ============================================================
# 互動式抗藥性熱圖腳本 (Interactive AMR Heatmap)
# ------------------------------------------------------------
# 本腳本由 Python pipeline 呼叫，負責：
#   1. 讀取指定 job 目錄下的抗藥性結果檔案
#   2. 完成樣本 / 地理 / 年份資訊的 one-hot 編碼
#   3. 匯出整理後的 hits_table.tsv、heatmap_data.tsv
#   4. 利用 heatmaply 輸出互動式熱圖 (HTML self-contained)
# 用法：
#   Rscript interactive_complex_heatmap.R <job_dir>
#   # 可透過環境變數 MYANTI_R_HEATMAP_OUTDIR 覆寫輸出資料夾
# ============================================================

suppressPackageStartupMessages({
  library(readr)
  library(dplyr)
  library(tidyr)
  library(stringr)
  library(jsonlite)
  library(heatmaply)
  library(htmlwidgets)
})

# ------------------------------------------------------------
# 1. 解析參數與輸出目錄初始化
# ------------------------------------------------------------
args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 1) {
  stop("缺少工作目錄參數 (job folder)")
}

job_dir <- normalizePath(args[1], winslash = "/", mustWork = FALSE)
if (!dir.exists(job_dir)) {
  stop("找不到工作目錄: ", job_dir)
}

out_dir <- Sys.getenv("MYANTI_R_HEATMAP_OUTDIR", file.path(job_dir, "6.heatmap"))
if (!nzchar(out_dir)) {
  out_dir <- file.path(job_dir, "6.heatmap")
}
if (!dir.exists(out_dir)) {
  dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)
}

# 小工具：統一日誌輸出與安全讀檔
log_message <- function(...) {
  cat(paste0(..., collapse = ""), "\n")
}

safe_read_tsv <- function(path, ...) {
  if (!file.exists(path)) {
    stop("缺少必要檔案: ", path)
  }
  readr::read_tsv(path, show_col_types = FALSE, progress = FALSE, ...)
}

# ------------------------------------------------------------
# 2. 讀取輸入檔案
# ------------------------------------------------------------
hits_profile_path <- file.path(job_dir, "3.abProfilesCmp", "hits_profile.tsv")
hits_table_path <- file.path(job_dir, "3.abProfilesCmp", "hits_table.tsv")
tax_assign_path <- file.path(job_dir, "1.taxAssign", "taxAssign.result")
country_path <- file.path(job_dir, "country")
formdata_path <- file.path(job_dir, "formData.json")

hits_profile <- safe_read_tsv(hits_profile_path)
hits_table <- safe_read_tsv(hits_table_path)

if (!file.exists(tax_assign_path)) {
  stop("缺少 taxAssign.result")
}
query_species_tbl <- readr::read_tsv(tax_assign_path, col_names = FALSE, show_col_types = FALSE)
species_name <- if (nrow(query_species_tbl) > 0) {
  gsub("_", " ", query_species_tbl[[1]][1])
} else {
  "Unknown"
}

country_value <- "Unknown"
if (file.exists(country_path)) {
  country_tbl <- try(suppressWarnings(readr::read_csv(country_path, col_names = FALSE, show_col_types = FALSE)), silent = TRUE)
  if (!inherits(country_tbl, "try-error") && nrow(country_tbl) > 0) {
    country_value <- country_tbl[[1]][1]
  }
}
if (country_value %in% c("", NA, "Unknown")) {
  if (file.exists(formdata_path)) {
    formdata <- try(jsonlite::read_json(formdata_path, simplifyVector = TRUE), silent = TRUE)
    if (!inherits(formdata, "try-error") && !is.null(formdata$country) && nzchar(formdata$country)) {
      country_value <- formdata$country
    }
  }
}
if (!nzchar(country_value)) {
  country_value <- "Unknown"
}

# ------------------------------------------------------------
# 3. hits_table 資料前處理 (加入 Query、One-Hot 編碼)
# ------------------------------------------------------------
processed_table <- hits_table %>%
  dplyr::select(
    Genome_ID = 2,
    Species = 3,
    Date = 5,
    Location = 6
  )

query_row <- tibble::tibble(
  Genome_ID = "Query",
  Species = species_name,
  Date = "-",
  Location = country_value
)
processed_table <- dplyr::bind_rows(query_row, processed_table) # 確保 Query 排最前

# --- 物種縮寫 One-Hot ---
species_abbr <- c(
  "Acinetobacter baumannii" = "AB",
  "Enterococcus faecium" = "EF",
  "Klebsiella pneumoniae" = "KP",
  "Pseudomonas aeruginosa" = "PA",
  "Staphylococcus aureus" = "SA"
)
processed_table <- processed_table %>%
  mutate(
    Abbr = species_abbr[Species]
  )

abbr_cols <- c("AB", "EF", "KP", "PA", "SA")
for (abbr in abbr_cols) {
  processed_table[[abbr]] <- ifelse(processed_table$Abbr == abbr, 1L, 0L)
}

# --- 地理資訊 One-Hot ---
location_to_region <- c(
  "Algeria" = "Africa", "Argentina" = "South_America", "Australia" = "Australia",
  "Austria" = "Europe", "Bangladesh" = "Asia", "Belgium" = "Europe",
  "Bolivia" = "South_America", "Bosnia_and_Herzegovina" = "Europe",
  "Brazil" = "South_America", "Cambodia" = "Asia", "Cameroon" = "Africa",
  "Canada" = "North_America", "Cape_Verde" = "Africa", "Chile" = "South_America",
  "China" = "Asia", "Colombia" = "South_America", "Croatia" = "Europe",
  "Cuba" = "North_America", "Czech_Republic" = "Europe", "DR_Congo" = "Africa",
  "Denmark" = "Europe", "Dominica" = "North_America",
  "Dominican_Republic" = "North_America", "Ecuador" = "South_America",
  "Egypt" = "Africa", "Estonia" = "Europe", "Ethiopia" = "Africa",
  "Finland" = "Europe", "France" = "Europe", "Gabon" = "Africa",
  "Gambia" = "Africa", "Gaza_Strip" = "Middle_East", "Germany" = "Europe",
  "Ghana" = "Africa", "Greece" = "Europe", "Guatemala" = "North_America",
  "Honduras" = "North_America", "Hong_Kong" = "Asia", "Hungary" = "Europe",
  "India" = "Asia", "Indonesia" = "Asia", "Iraq" = "Middle_East",
  "Ireland" = "Europe", "Israel" = "Middle_East", "Italy" = "Europe",
  "Japan" = "Asia", "Jordan" = "Middle_East", "Kazakhstan" = "Asia",
  "Kenya" = "Africa", "Kuwait" = "Middle_East", "Latvia" = "Europe",
  "Lebanon" = "Middle_East", "Libya" = "Africa", "Lithuania" = "Europe",
  "Luxembourg" = "Europe", "Madagascar" = "Africa", "Malaysia" = "Asia",
  "Malta" = "Europe", "Martinique" = "North_America", "Mayotte" = "Africa",
  "Mexico" = "North_America", "Morocco" = "Africa", "Mozambique" = "Africa",
  "Namibia" = "Africa", "Nepal" = "Asia", "Netherlands" = "Europe",
  "New_Zealand" = "Australia", "Nigeria" = "Africa", "Norway" = "Europe",
  "Oman" = "Middle_East", "Pakistan" = "Asia", "Peru" = "South_America",
  "Philippines" = "Asia", "Poland" = "Europe", "Portugal" = "Europe",
  "Puerto_Rico" = "North_America", "Qatar" = "Middle_East", "Romania" = "Europe",
  "Russia" = "Asia", "Saint_Kitts_and_Nevis" = "North_America",
  "Samoa" = "Oceania", "Saudi_Arabia" = "Middle_East", "Senegal" = "Africa",
  "Serbia" = "Europe", "Singapore" = "Asia", "Slovakia" = "Europe",
  "Slovenia" = "Europe", "South_Africa" = "Africa", "South_Korea" = "Asia",
  "Spain" = "Europe", "Sudan" = "Africa", "Suriname" = "South_America",
  "Sweden" = "Europe", "Switzerland" = "Europe", "Taiwan" = "Asia",
  "Tanzania" = "Africa", "Thailand" = "Asia", "Togo" = "Africa",
  "Trinidad_and_Tobago" = "South_America", "Tunisia" = "Africa",
  "Turkey" = "Middle_East", "USA" = "North_America", "Uganda" = "Africa",
  "Ukraine" = "Europe", "United_Kingdom" = "Europe",
  "Venezuela" = "South_America", "Viet_Nam" = "Asia"
)
processed_table <- processed_table %>%
  mutate(
    Country = dplyr::recode(Location, !!!location_to_region, .default = "Other")
  )

region_cols <- c(
  "Asia", "Middle_East", "Europe", "Africa",
  "North_America", "South_America", "Australia", "Oceania"
)
for (region in region_cols) {
  processed_table[[paste0("X", region)]] <- ifelse(processed_table$Country == region, 1L, 0L)
}

# --- 年份資訊 One-Hot ---
processed_table <- processed_table %>%
  mutate(
    Year = if_else(str_detect(Date, "^\\d{4}"), as.integer(substr(Date, 1, 4)), 0L)
  )

year_cols <- as.character(2000:2021)
for (year in year_cols) {
  processed_table[[year]] <- ifelse(processed_table$Year == as.integer(year), 1L, 0L)
}

metadata_table <- processed_table # 保留完整欄位供 hover/RowSideColors 使用

processed_table_ok <- processed_table %>%
  select(-Date, -Location, -Abbr, -Country, -Year)

# ------------------------------------------------------------
# 4. 輸出整理後表格 (hits_table.tsv, heatmap_data.tsv)
# ------------------------------------------------------------
hits_table_out <- file.path(out_dir, "hits_table.tsv")
readr::write_tsv(processed_table_ok, hits_table_out)
log_message("✅ 已輸出 hits_table.tsv → ", hits_table_out)

heatmap_data <- hits_profile %>%
  left_join(processed_table_ok, by = "Genome_ID") %>%
  mutate(Genome_ID = coalesce(Genome_ID, "Unknown")) %>%
  slice(match(hits_profile$Genome_ID, Genome_ID))

heatmap_data_out <- file.path(out_dir, "heatmap_data.tsv")
readr::write_tsv(heatmap_data, heatmap_data_out)
log_message("✅ 已輸出 heatmap_data.tsv → ", heatmap_data_out)

# ------------------------------------------------------------
# 5. 準備熱圖矩陣與註解資訊
# ------------------------------------------------------------
feature_cols <- setdiff(colnames(hits_profile), "Genome_ID")
if (length(feature_cols) == 0) {
  stop("hits_profile.tsv 缺少抗藥性欄位，無法繪圖")
}

mat <- heatmap_data %>%
  select(all_of(feature_cols)) %>%
  as.matrix()
rownames(mat) <- heatmap_data$Genome_ID
mat[is.na(mat)] <- 0

metadata_lookup <- metadata_table %>%
  mutate(
    Species = coalesce(Species, "Unknown"),
    Display_Species = case_when(
      Species == "Acinetobacter baumannii" ~ "A. baumannii",
      Species == "Enterococcus faecium" ~ "E. faecium",
      Species == "Klebsiella pneumoniae" ~ "K. pneumoniae",
      Species == "Pseudomonas aeruginosa" ~ "P. aeruginosa",
      Species == "Staphylococcus aureus" ~ "S. aureus",
      TRUE ~ Species
    ),
    Region = dplyr::recode(Country, !!!setNames(region_cols, region_cols), .default = Country)
  ) %>%
  select(Genome_ID, Display_Species, Location, Region)

# 自訂 hover 文字：提供樣本、抗生素、物種、地理資訊
hover_text <- matrix("", nrow = nrow(mat), ncol = ncol(mat))
for (i in seq_len(nrow(mat))) {
  row_id <- rownames(mat)[i]
  meta_row <- metadata_lookup %>% filter(Genome_ID == row_id)
  sp <- if (nrow(meta_row) > 0) meta_row$Display_Species[[1]] else "Unknown"
  loc <- if (nrow(meta_row) > 0) meta_row$Location[[1]] else "-"
  region_val <- if (nrow(meta_row) > 0) meta_row$Region[[1]] else "-"
  for (j in seq_len(ncol(mat))) {
    hover_text[i, j] <- sprintf(
      "樣本: %s<br>抗生素: %s<br>值: %.2f<br>物種: %s<br>地點: %s<br>地區: %s",
      row_id, feature_cols[j], mat[i, j], sp, loc, region_val
    )
  }
}

# RowSideColors：顯示物種 / 地區 / Query 樣本
row_side <- metadata_lookup %>%
  mutate(
    Species = factor(Display_Species),
    Region = factor(Region),
    Query = factor(if_else(Genome_ID == "Query", "Query", "Reference"), levels = c("Reference", "Query"))
  ) %>%
  select(Genome_ID, Species, Region, Query) %>%
  tibble::column_to_rownames("Genome_ID")

color_scale <- colorRampPalette(c("#a5d96a", "#d9ef8b", "#fedf8b", "#fdaf61", "#f46c43"))(256)

# ------------------------------------------------------------
# 6. 使用 heatmaply 產生互動式熱圖
# ------------------------------------------------------------
heatmap_widget <- heatmaply::heatmaply(
  mat,
  RowSideColors = row_side,
  colors = color_scale,
  plot_method = "plotly",
  scale = "none",
  xlab = "Antibiotics",
  ylab = "Samples",
  main = "Interactive AMR Heatmap",
  column_text_angle = 90,
  hide_colorbar = FALSE,
  custom_hovertext = hover_text,
  showticklabels = c(TRUE, TRUE),
  limits = c(0, 100),
  dendrogram = "row"
)

# ------------------------------------------------------------
# 7. 輸出 self-contained HTML
# ------------------------------------------------------------
html_file <- file.path(out_dir, "ComplexHeatmap_interactive.html")
htmlwidgets::saveWidget(heatmap_widget, file = html_file, selfcontained = TRUE)
log_message("✅ 已輸出互動式熱圖 HTML → ", html_file)

log_message("🎉 完成互動式 R 熱圖生成")