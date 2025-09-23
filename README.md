# ICA Report Template

[![Quarto](https://img.shields.io/badge/quarto-1.4.555-darkgreen.svg)](https://quarto.org/)
[![R](https://img.shields.io/badge/R-4.3.0-blue.svg)](https://www.r-project.org/)

## Overview

This repository contains a Quarto template and R script for automating the generation of Institutional Capacity Assessment (ICA) reports for departments within the Vanuatu Public Service Commission (PSC). The template produces professional PDF reports based on the 2025 Institutional Capacity Assessment Grid (ICAG) survey data, conducted in August 2025.

The reports evaluate 31 capacity categories (e.g., strategic planning, human resources, infrastructure) on a scale of 1 (Clear Need) to 4 (High), providing visualizations, summaries of strengths and weaknesses, development priorities, and recommendations. Departments with four or fewer responses are filtered out to ensure reliable analysis. Reports are organized into ministry-specific folders for structured output.

This tool supports the National Sustainable Development Plan (NSDP) by enabling efficient, reproducible report generation for individual departments or across ministries.

**Current Version**: Based on the 2025 ICA survey (as of September 19, 2025).

## Features

- **Automated Batch Reporting**: Generates individual PDF reports for each department, organized in ministry-specific folders.
- **Data Filtering**: Excludes departments with ≤4 responses for statistical reliability.
- **Visualizations**: Includes bar charts for capacity scores and descriptive tables.
- **Customizable**: Easily adaptable for future surveys by updating the data CSV and category list.
- **Professional Output**: PDF reports with table of contents, list of tables/figures, LaTeX styling, and hyperlinks.
- **Reproducible**: Uses R and Quarto for transparent, version-controlled workflows.

## Prerequisites

- **R** (version 4.3.0 or later)
- **Quarto** (version 1.4.555 or later) – Install from [quarto.org](https://quarto.org/docs/get-started/)
- **R Packages**: 
  - `dplyr`, `readr`, `stringr`, `quarto`
  - Install via: `install.packages(c("dplyr", "readr", "stringr", "quarto"))`
- **Pandoc** (included with Quarto)
- **XeLaTeX** (for PDF rendering; install via TeX Live or MiKTeX)
- **Font**: Source Sans 3 (download from [Google Fonts](https://fonts.google.com/specimen/Source+Sans+3) if needed)

## Setup

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/htevilili-1991/ICA-Report-Template.git
   cd ICA-Report-Template
   ```

2. **Prepare Images**:
   - Create an `img/` folder in the root directory.
   - Add required images:
     - `Capacity-people-context-environment.png`
     - `factors-influencing-capacity.png`
     - `five-steps-assessing-planning-capacity-development.png`

3. **Install Dependencies**:
   - Run in R/RStudio:
     ```r
     install.packages(c("dplyr", "readr", "stringr", "quarto", "tidyr", "ggplot2", "kableExtra"))
     ```

4. **Create Output Directory**:
   - Create a `Reports/` folder in the root directory to store generated PDFs, organized by ministry.

## Data Requirements

- **Input File**: `ica_cleaned_data.csv` (place in the root directory).
  - **Format**: CSV with columns for `Ministry`, `Department`, respondent details (e.g., ID, email), and 31 capacity category columns (exact names as defined in the template, e.g., "Clarity of Vision", "Mission and Purpose").
  - **Scoring**: Numeric values (1–4) based on ICAG scale (A=1 Clear Need, B=2 Basic, C=3 Moderate, D=4 High).
  - **Privacy Note**: Do not commit sensitive data to Git. The CSV is excluded from this repository for confidentiality.
- **Example Structure** (subset):
  | Ministry | Department | Clarity of Vision | Mission and Purpose | ... |
  |----------|------------|-------------------|---------------------|-----|
  | MALFFB  | Dept A    | 3                 | 4                   | ... |

- **Filtering**: The template automatically excludes departments with ≤4 responses.

## Usage

### Batch Report Generation
The provided R script (`generate_reports.R`) automates report generation for all departments with >4 responses, organizing outputs into ministry-specific folders.

1. Place `ica_cleaned_data.csv` in the root directory.
2. Run the script:
   ```r
   source("generate_reports.R")
   ```
   - **Input**: `ICA_Report_Template.qmd`
   - **Output**: PDFs in `Reports/<safe_ministry_name>/ICA_Report_<safe_department_name>.pdf` (e.g., `Reports/MALFFB/ICA_Report_Department_of_Water_Resources.pdf`)

3. **Script Details**:
   - Loads `ica_cleaned_data.csv` and filters departments with ≤4 responses.
   - Creates a folder for each ministry (e.g., `Reports/MALFFB/`).
   - Renders a report for each department using `quarto::quarto_render`.
   - Moves PDFs to the appropriate ministry folder.

### Single Report (Parameterized)
To generate a report for a specific department:
```bash
quarto render ICA_Report_Template.qmd \
  --to pdf \
  -P ministry:"Ministry of Agriculture, Livestock, Forestry, Fisheries and Biosecurity" \
  -P department:"Department of Water Resources"
```
- **Output**: `ICA_Report_Department_of_Water_Resources.pdf` in the `Reports/MALFFB/` folder.

### In RStudio
- Open `ICA_Report_Template.qmd`.
- Set `ministry` and `department` in the YAML params or use the script.
- Click "Render" or run `source("generate_reports.R")`.

## Output

- **PDF Report Structure**:
  - Title page with ministry/department.
  - List of abbreviations.
  - Acknowledgments, Introduction, Background.
  - Methodology (data collection, processing, analysis).
  - Results: Bar chart of capacity scores, strongest/weakest tables, top 10 priorities with recommendations.
  - Appendices: Descriptive stats, planning guide.
- **File Organization**: Reports are saved in `Reports/<safe_ministry_name>/ICA_Report_<safe_department_name>.pdf`.
- **Images**: Embedded diagrams for capacity concepts and ICAG process.
- **Tables**: Styled with booktabs, colors, and hyperlinks.

Example rendered report: [View Sample PDF](https://example.com/sample-report.pdf) (placeholder; generate your own).

## Customization

- **Update Categories**: Modify `capacity_categories` vector in `ICA_Report_Template.qmd`.
- **Recommendations**: Edit the `recommendations` vector in the template.
- **Styling**: Adjust LaTeX in `include-in-header` (e.g., colors, fonts).
- **Year/Date**: Change `year = 2025` variable.
- **Thresholds**: Adjust filtering (`n() > 4`) or weak scores (`<= 2`).
- **Output Path**: Modify the `Reports/` directory structure in `generate_reports.R`.

For future surveys, update the CSV and re-run the script.

## File Structure

```
ICA-Report-Template/
├── ICA_Report_Template.qmd    # Quarto template
├── generate_reports.R         # Script to automate report generation
├── img/                      # Folder for images
│   ├── Capacity-people-context-environment.png
│   ├── factors-influencing-capacity.png
│   ├── five-steps-assessing-planning-capacity-development.png
├── Reports/                  # Output folder for PDFs
│   ├── MALFFB/              # Ministry-specific folder
│   │   ├── ICA_Report_Department_of_Water_Resources.pdf
│   ├── MoET/                # Another ministry folder
│   │   ├── ...
├── README.md                 # This file
├── LICENSE                   # MIT License
```

**Note**: `ica_cleaned_data.csv` is not included in the repository for privacy reasons.

## Troubleshooting

- **PDF Rendering Error**: Ensure XeLaTeX and Source Sans 3 are installed. Test with `quarto check`.
- **Missing Images**: Verify `img/` folder paths.
- **Data Issues**: Ensure CSV column names match `capacity_categories`. Use `readr::spec_csv("ica_cleaned_data.csv")` to inspect.
- **File Not Found**: Check that PDFs are generated in the working directory before moving to `Reports/`.
- **Low Responses**: Filtered departments are skipped; check console for warnings.
- **Quarto Errors**: Update Quarto/R; see [Quarto Docs](https://quarto.org/docs/troubleshooting/).

## Contributing

Contributions are welcome! Fork the repo, make changes, and submit a pull request. Focus on:
- Bug fixes for rendering or file handling.
- Enhancements for multi-year comparisons or additional visualizations.
- Documentation improvements.

Please adhere to [Google's R Style Guide](https://google.github.io/styleguide/Rguide.html).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Vanuatu Public Service Commission (PSC) and Vanuatu Bureau of Statistics (VBoS) for data and support.
- Quarto Team for the publishing framework.
- R Community for open-source tools.

For questions, contact [Your Name/Email] or open an issue.

---

*Last Updated: September 19, 2025*
