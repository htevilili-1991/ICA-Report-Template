# Institutional Capacity Assessment (ICA) Report Generator

[![Quarto](https://img.shields.io/badge/quarto-1.4.555-darkgreen.svg)](https://quarto.org/)
[![R](https://img.shields.io/badge/R-4.3.0-blue.svg)](https://www.r-project.org/)


This repository contains tools for generating Institutional Capacity Assessment (ICA) reports for the Vanuatu Public Service Commission (PSC). The reports assess organizational capacity across 31 categories (e.g., strategic planning, human resource management, infrastructure) using the Institutional Capacity Assessment Grid (ICAG). The system supports two types of reports:

1. **Department-Level Reports**: Detailed assessments for individual departments within a ministry, generated using `ICA_Report_Template.qmd`.
2. **Ministry-Level Comparative Report**: A comparative analysis across all ministries, generated using `ICA_All_Ministries_Report.qmd`.

Reports are produced as PDFs using Quarto, with data processing, analysis, and visualizations handled in R. The assessments align with the National Sustainable Development Plan (NSDP) Society Pillar Goal 6, aiming to strengthen public institutions by identifying capacity strengths, weaknesses, and actionable priorities.

## Purpose

- **Assess Organizational Capacity**: Quantify and visualize capacity levels (scored 1–4, from "Clear Need" to "High") across key areas like strategic direction, operations, and infrastructure.
- **Identify Priorities**: Highlight strongest capacities, top development priorities (mean scores ≤ 2.5), and urgent areas (mean scores < 2) for targeted improvement.
- **Provide Recommendations**: Offer evidence-based actions to enhance capacity, supporting strategic planning and resource allocation.
- **Automate Reporting**: Generate customized PDF reports efficiently, either for a single department or in batch for all departments, organized by ministry, and a comparative report across ministries.

## Repository Structure

### Main Files

- **ICA_Report_Template.qmd**: Quarto template for generating department-level ICA reports. It includes:
  - YAML header for PDF formatting (e.g., fonts, colors, table of contents, LaTeX styling).
  - R code chunks for loading and filtering data, calculating statistics (mean, SD, etc.), identifying strongest/weakest capacities, and generating visualizations (bar plots, tables).
  - Sections: Abbreviations, Acknowledgments, Introduction, Background, Methodology, Results (with strongest capacities, priorities, and urgent areas), and Appendices.
  - Dynamic content using parameters (`params$ministry`, `params$department`) to customize reports.

- **render_department_report.R**: R script to automate batch rendering of department-level reports. It:
  - Loads data from `ica_cleaned_data.csv`.
  - Filters departments with >4 responses.
  - Creates ministry-specific folders under `Reports/`.
  - Renders a PDF for each unique ministry-department pair, saving outputs as `ICA_Report_<Department>.pdf` in the respective ministry folder.

- **ICA_All_Ministries_Report.qmd**: Quarto template for a comparative report across all ministries. It includes:
  - YAML header similar to `ICA_Report_Template.qmd`, with additional LaTeX packages (e.g., `pdflscape` for landscape tables).
  - R code for aggregating data by ministry, calculating overall capacity scores, identifying strongest/weakest ministries and categories, and generating a heatmap.
  - Sections: Abbreviations, Acknowledgments (noting low-response departments), Introduction, Methodology, Results (with ministry rankings, heatmap, and priorities), and Appendices with detailed statistics.
  - Visualizes capacity variations across ministries, focusing on top 5 strongest and weakest categories.

- **ica_cleaned_data.csv**: Input data file (not included; user-provided). Contains survey responses with columns for `Ministry`, `Department`, and the 31 capacity categories (e.g., "Clarity of Vision", "Mission and Purpose"). Scores are numeric (1–4).

- **img/**: Directory for images used in reports (e.g., `Capacity-people-context-environment.png`, `factors-influencing-capacity.png`, `five-steps-assessing-planning-capacity-development.png`).

## Requirements

- **Quarto**: Version 1.0 or later (for rendering QMD to PDF). Install from [quarto.org](https://quarto.org/docs/get-started/).
- **R**: Version 4.0 or later, with packages:
  - `dplyr`, `tidyr`, `ggplot2`, `kableExtra`, `readr`, `stringr`, `quarto` (install via `install.packages(c("dplyr", "tidyr", "ggplot2", "kableExtra", "readr", "stringr", "quarto"))`).
- **LaTeX/PDF Engine**: XeLaTeX (via TinyTeX or a full TeX distribution) for PDF output. Install TinyTeX in R with `tinytex::install_tinytex()`.
- **Data File**: `ica_cleaned_data.csv` in the project root or specified path, with columns matching the 31 capacity categories defined in the templates.
- **Images**: Place required images in an `img/` subdirectory.

## Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd <repository-directory>
   ```
2. Install R dependencies:
   ```bash
   Rscript -e 'install.packages(c("dplyr", "tidyr", "ggplot2", "kableExtra", "readr", "stringr", "quarto"))'
   ```
4. Ensure Quarto is installed and on your PATH.
5. Place ica_cleaned_data.csv in the project root or specify its path in the scripts.
6. Create an img/ directory and add required images.

## Usage
### Generating Department-Level Reports
**Single Department Report**
To generate a report for a specific department:
```bash
quarto render ICA_Report_Template.qmd --to pdf --execute-params params.yml
```
Where params.yml is:
```bash
ministry: "Ministry of Example"
department: "Department of Example"
```
Output: ICA_Report_Template.pdf (or custom name via --output).

**Batch Rendering for All Departments**
To generate reports for all departments with >4 responses, organized by ministry:
```bash
Rscript render_department_report.R
```
- Creates Reports/<Ministry>/ICA_Report_<Department>.pdf for each ministry-department pair.
- Uses ica_cleaned_data.csv to identify unique pairs.
- Sanitizes file names by replacing non-alphanumeric characters with underscores.

### Generating Ministry-Level Comparative Report
To generate the comparative report across all ministries:
```bash
quarto render ICA_All_Ministries_Report.qmd --to pdf
```
Output: ICA_All_Ministries_Report.pdf.

### Key Features
- **Department Reports**(ICA_Report_Template.qmd):
  - Dynamic filtering by ministry and department.
  - Visualizations: Bar plots of capacity scores, tables for priorities, and descriptive statistics.
  - Conditional text for urgent capacities (mean < 2).
  - Recommendations tailored to low-scoring categories.
- **Batch Rendering** (render_department_report.R):
  - Automates report generation for all valid departments.
  - Organizes outputs in ministry-specific folders.
  - Preserves original working directory.
- **Comparative Report** (ICA_All_Ministries_Report.qmd)":
  - Aggregates data by ministry, ranking overall capacity.
  - Heatmap comparing top 5 strongest and weakest categories.
  - Identifies ministries and categories needing urgent attention (mean ≤ 2).
  - Detailed appendices with statistics.
- **Data Processing**:
  - Filters out departments with ≤4 responses for reliability.
  - Maps ministry names to abbreviations (e.g., "Ministry of Health" to "MoH").
  - Computes mean scores, standard deviations, and distributions.
- **Styling**:
  - Consistent LaTeX formatting (Source Sans 3 font, blue headers, gray text).
  - Tables with kableExtra for professional appearance.
  - Color-coded visualizations (red for low, green for high scores).

### Data Assumptions
- ica_cleaned_data.csv must have:
  - Columns: Ministry, Department, and exact matches for the 31 capacity categories (listed in capacity_categories vector in both QMD files).
  - Numeric scores (1–4) for categories; text responses must be pre-converted (not handled in templates).
- Departments with ≤4 responses are filtered out in department reports and noted in the comparative report.
- Ministry names in the data should match those in ministry_abbreviations (in ICA_All_Ministries_Report.qmd) or be pre-cleaned.

### Customization
- Add/Modify Categories: Update the capacity_categories vector in both QMD files and adjust computations (e.g., stats, plots).
- Recommendations: Edit the recommendations vector in ICA_Report_Template.qmd or case_when in ICA_All_Ministries_Report.qmd for tailored actions.
- Descriptions: Modify switch statements in ICA_Report_Template.qmd to update capacity descriptions.
- Styling: Adjust LaTeX includes in YAML headers for fonts, colors, or layout.
- Output Paths: Modify render_department_report.R to change the Reports/ directory structure.

### Limitations
- No error handling for missing ica_cleaned_data.csv or invalid parameters—ensure data exists and parameters are valid.
- Assumes all capacity columns are present in the CSV; mismatches cause errors.
- Batch rendering sanitizes file names, which may result in non-descriptive outputs for complex department names.
- Heatmap in the comparative report focuses on top 5 strongest/weakest categories; modify focus_categories for different selections.
- Visualizations (bar plots, heatmap) have fixed themes; customize ggplot2 code for alternative styles.
- Low-response departments (≤4) are excluded, potentially omitting smaller units.

### Contributions are welcome! To contribute:
- Fork the repository.
- Create a feature branch (git checkout -b feature-name).
- Commit changes (git commit -m "Add feature").
- Push to the branch (git push origin feature-name).
- Open a pull request.

Please include tests for new features and update documentation as needed.

