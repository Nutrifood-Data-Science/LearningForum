rm(list=ls())

library(EBImage)
library(dplyr)
library(tidyr)
library(parallel)

ncore = detectCores()

# Load the image
img <- readImage("1-25.png")

# Get the dimensions of the image array
img_dims <- dim(img)
print(paste("Image dimensions (Height, Width, Channels):", paste(img_dims, collapse=", ")))

# Check if the image has color channels (at least 3)
if (length(img_dims) < 3 || img_dims[3] < 3) {
  stop("Error: Image does not appear to have standard RGB color channels. It might be grayscale.")
}

# Extract the green channel (the 2nd dimension slice)
# The syntax img[,,2] selects all rows, all columns, and the 2nd channel (Green)
green_channel <- img[,,2]

# Calculate the average green intensity
# This gives a single value representing the overall greenness
average_green_intensity <- mean(green_channel)

# --- Optional: Other Metrics ---

# Calculate the proportion of pixels with high green intensity
# Define a threshold (e.g., 0.7). Adjust as needed.
green_threshold <- 0.7
high_green_pixels <- sum(green_channel > green_threshold)
total_pixels <- nrow(green_channel) * ncol(green_channel) # or length(green_channel)
proportion_high_green <- high_green_pixels / total_pixels

# Calculate Green Dominance (average difference between Green and other colors)
# This requires the Red and Blue channels as well
if (img_dims[3] >= 3) {
  red_channel <- img[,,1]
  blue_channel <- img[,,3]
  # Calculate per-pixel green dominance score (G - R + G - B) / 2
  # Values range from -1 (no green relative to others) to +1 (full green relative to others)
  green_dominance_per_pixel <- ( (green_channel - red_channel) + (green_channel - blue_channel) ) / 2
  average_green_dominance <- mean(green_dominance_per_pixel)
} else {
  average_green_dominance <- NA # Not applicable if only R and G exist or grayscale
}


# --- Display Results ---

print(paste("Average Green Intensity (0-1 scale):", round(average_green_intensity, 4)))
print(paste("Proportion of Pixels with Green >", green_threshold, ":", round(proportion_high_green, 4)))
if (!is.na(average_green_dominance)) {
  print(paste("Average Green Dominance Score (-1 to 1 scale):", round(average_green_dominance, 4)))
} else {
  print("Green Dominance Score could not be calculated (missing R/B channels).")
}