library(dplyr)
library(readr)
library(stringr)
library(quarto)

setwd("~/Documents/Work/ICA/ICA Report")

# Load data
data <- read_csv("ica_cleaned_data.csv", show_col_types = FALSE)

# Get unique Ministry and Department pairs
unique_ministry_dept <- data %>%
  select(Ministry, Department) %>%
  distinct() %>%
  arrange(Ministry)

# Loop through each pair and render a report
for (i in seq_len(nrow(unique_ministry_dept))) {
  params_list <- list(
    ministry = unique_ministry_dept$Ministry[i],
    department = unique_ministry_dept$Department[i]
  )
  
  safe_dept <- str_replace_all(unique_ministry_dept$Department[i], "[^[:alnum:]]", "_")
  safe_min <- str_replace_all(unique_ministry_dept$Ministry[i], "[^[:alnum:]]", "_")
  output_file <- paste0("ICA Report - ", safe_dept, ".pdf")
  
  quarto::quarto_render(
    input = "ICA_Report_Template.qmd",
    execute_params = params_list,
    output_file = output_file,
    output_format = "pdf"
  )
}