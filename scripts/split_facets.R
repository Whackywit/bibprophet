#' Split a faceted ggplot into individual images
#'
#' This script creates a reproducible example that mimics a two-panel
#' (faceted) chart and shows how to export each facet as its own image
#' using ggplot2.  The same pattern can be applied to your own data by
#' replacing the example data frames with your real values.

library(ggplot2)

# -----------------------------------------------------------------------------
# 1. Build a small toy data set that looks similar to the chart in the prompt.
#    Replace this block with a read.csv() call (or any other data import) when
#    working with your own data.
# -----------------------------------------------------------------------------
years <- seq(2020, 2030, by = 2)
pathways <- c("Baseline", "Assistive AI", "Human + AI", "Full Automation")

make_panel <- function(panel_name, offsets) {
  data.frame(
    panel = panel_name,
    pathway = rep(pathways, each = length(years)),
    year = rep(years, times = length(pathways)),
    value = c(
      16 + offsets[1] + seq_along(years) * 0.2,
      17 + offsets[2] + seq_along(years) * 0.4,
      18.5 + offsets[3] + seq_along(years) * 0.35,
      19 + offsets[4] + seq_along(years) * 0.45
    )
  )
}

example_data <- rbind(
  make_panel("Efficiency / DEA", c(0.0, 0.4, -0.2, 0.6)),
  make_panel("Pathway / AI", c(0.5, -0.1, 0.8, 0.2))
)

# -----------------------------------------------------------------------------
# 2. Build a helper that turns a data frame subset into a formatted plot.
# -----------------------------------------------------------------------------
plot_panel <- function(panel_name) {
  panel_data <- subset(example_data, panel == panel_name)

  ggplot(panel_data, aes(year, value, colour = pathway)) +
    geom_line(linewidth = 0.8) +
    geom_point(size = 2) +
    scale_colour_brewer(palette = "Set2") +
    scale_x_continuous(breaks = years) +
    labs(
      title = panel_name,
      x = NULL,
      y = "Composite score",
      colour = NULL
    ) +
    theme_minimal(base_size = 13) +
    theme(
      panel.grid.major = element_line(colour = "grey85"),
      panel.grid.minor = element_blank(),
      plot.title = element_text(face = "bold", hjust = 0.5),
      legend.position = "bottom"
    )
}

# -----------------------------------------------------------------------------
# 3. Create one figure per panel and export each to disk.
# -----------------------------------------------------------------------------
dir.create("plots", showWarnings = FALSE)

panels <- unique(example_data$panel)
for (panel_name in panels) {
  plot_object <- plot_panel(panel_name)
  file_name <- sprintf("plots/%s.png", gsub("[/ ]", "_", panel_name))
  ggsave(file_name, plot_object, width = 6, height = 6, dpi = 300)

  # Print the plot so it shows up in viewers such as the RStudio Plots pane.
  if (interactive()) {
    print(plot_object)
  }
}

# If you would still like to see the combined two-panel chart, you can use a
# facet call like below.  (Not exported by default.)
# ggplot(example_data, aes(year, value, colour = pathway)) +
#   geom_line(linewidth = 0.8) +
#   geom_point(size = 2) +
#   scale_colour_brewer(palette = "Set2") +
#   facet_wrap(~panel) +
#   theme_minimal()
