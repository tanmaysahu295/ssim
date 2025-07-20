#install.packages("languageserver")
library(languageserver)
#install.packages("devtools")
library(devtools)
install_github("sthonnard/ssimparser")

library(ssimparser)

# Check if ssimparser loaded correctly
cat("Checking if ssimparser is loaded:\n")
cat("Is ssimparser in search path?", "package:ssimparser" %in% search(), "\n")

# Load SSIM test data
ssim_data_file <- "SSIM TEST DATA.txt"

# Check if the file exists
if (file.exists(ssim_data_file)) {
  # Check what functions are available in ssimparser
  cat("Available functions in ssimparser:\n")
  print(ls("package:ssimparser"))

  # Parse the SSIM data using the correct function name
  # You can use different options:
  # expand_sched = TRUE to expand schedules into individual flights
  # nested_df = TRUE to nest the data
  ssim_data <- load_ssim(ssim_data_file, expand_sched = TRUE, nested_df = FALSE)

  # Display basic information about the loaded data
  cat("SSIM data loaded successfully!\n")
  #cat("Data structure:\n") # nolint
  #str(ssim_data) # nolint: commented_code_linter.

  # Display first few records if available
  if (length(ssim_data) > 0) {
    cat("\nFirst few records:\n")
    print(ssim_data)

    cat("SSIM data loaded successfully!\n")
  }

  if (length(ssim_data) > 0) {
    cat("\nFirst few records:\n")
    print(ssim_data)
    # Save as Feather for Python interoperability
    if (!requireNamespace("arrow", quietly = TRUE)) {
      install.packages("arrow", repos = "https://cloud.r-project.org")
    }
    library(arrow)
    write_feather(as.data.frame(ssim_data), "ssim_data_output.feather")
    cat("Data has been written to ssim_data_output.feather\n")
  }

} else {
  cat("Error: SSIM TEST DATA.txt file not found in the current directory.\n")
  cat("Current working directory:", getwd(), "\n")
}
