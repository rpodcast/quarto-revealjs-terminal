library(rix)

rix(
  r_ver = "4.5.2",
  r_pkgs = c(
    "palmerpenguins",
    "quarto",
    "dplyr",
    "ggplot2"
  ),
  system_pkgs = "quarto",
  ide = "none",
  project_path = getwd(),
  overwrite = TRUE
)
