make_plot <- function(.data, company) {
  pivot_names <- names(.data)[-1]
  filtered_data <- .data |>
    filter(Company == company) |>
    select(-Company) |>
    pivot_longer(
      cols = any_of(pivot_names),
      names_to = "Line",
      values_to = "Amount"
    )

  data_labels <- scales::label_number(
    accuracy = 0.1,
    style_negative = "parens",
    big.mark = ","
  )(filtered_data$Amount)

  final_plot <- waterfalls::waterfall(
    .data = filtered_data,
    calc_total = FALSE,
    draw_lines = FALSE,
    total_rect_color = "green",
    rect_text_labels = data_labels
  ) +
    theme_minimal() +
    scale_y_continuous(
      name = "Amount",
      labels = scales::label_comma()
    ) +
    labs(
      title = glue::glue("{company}"),
      subtitle = "Insurance Service Result",
      x = "Line Item"
    )

  return(final_plot)
}
