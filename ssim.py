import pandas as pd
import subprocess
import sys
import os

# Run the R script to generate the feather file
r_script = "ssim.R"
result = subprocess.run(
    ["Rscript", r_script],
    capture_output=True,
    text=True
)

# Print R output for debugging
print(result.stdout)
if result.returncode != 0:
    print("Error running R script:", result.stderr)
    sys.exit(1)

# Read the feather file as pandas DataFrame
df = pd.read_feather("ssim_data_output.feather")
print(df.head())