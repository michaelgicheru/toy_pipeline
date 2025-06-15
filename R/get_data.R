get_raw_data <- function(
  url = "https://github.com/michaelgicheru/reproducibility_presentation/raw/master/data/ira_report_2023.xlsx",
  sheet_name = "APPENDIX 1"
) {
  raw_data <- tempfile(fileext = ".xlsx")

  download.file(url = url, destfile = raw_data, method = "auto", mode = "wb")

  raw_data <- readxl::read_xlsx(
    path = raw_data,
    sheet = "APPENDIX 1",
    skip = 3,
    n_max = 38
  )
}

clean_raw_data <- function(raw_data) {
  raw_data |>
    slice(-1) |>
    mutate(across(
      all_of(c(
        "Insurance Service Expense",
        "Net expenses from reinsurance contracts held"
      )),
      ~ .x * -1
    )) |>
    select(Company:`Insurance Service Result`)
}
