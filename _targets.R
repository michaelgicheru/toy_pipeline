library(targets)
library(tarchetypes)

tar_source()
tar_option_set(packages = c("dplyr", "tibble", "ggplot2", "tidyr"))


list(
  # raw data
  tar_target(
    name = raw_data,
    command = get_raw_data(
      url = "https://github.com/michaelgicheru/reproducibility_presentation/raw/master/data/ira_report_2023.xlsx",
      sheet_name = "APPENDIX 1"
    )
  ),
  # clean data
  tar_target(
    name = clean_data,
    command = clean_raw_data(raw_data = raw_data)
  ),
  # list of companies
  tar_target(
    name = companies,
    comman = c(
      "BRITAM GENERAL INSURANCE",
      "ICEA LION GENERAL INSURANCE",
      "CIC GENERAL INSURANCE COMPANY",
      "JUBILEE HEALTH INSURANCE",
      "APA INSURANCE COMPANY"
    )
  ),
  tar_render(
    analyse_data,
    "index.Rmd"
  )
)
