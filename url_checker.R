#!/usr/bin/env Rscript

# URL Checker Script for awesome-R repository
# Extracts and tests all URLs from markdown files

library(httr)

# Function to extract URLs from a file
extract_urls <- function(file_path) {
  if (!file.exists(file_path)) {
    return(data.frame())
  }
  
  lines <- readLines(file_path, warn = FALSE)
  
  # Extract URLs using regex
  url_pattern <- "https?://[^\\s\\)\\]>\"']+"
  
  urls_data <- data.frame()
  
  for (i in seq_along(lines)) {
    matches <- gregexpr(url_pattern, lines[i], perl = TRUE)
    urls <- regmatches(lines[i], matches)[[1]]
    
    if (length(urls) > 0) {
      for (url in urls) {
        # Clean up URLs (remove trailing punctuation)
        url <- gsub("[,;:!.]+$", "", url)
        url <- gsub("\\)$", "", url)
        
        urls_data <- rbind(urls_data, data.frame(
          file = file_path,
          line = i,
          url = url,
          stringsAsFactors = FALSE
        ))
      }
    }
  }
  
  return(urls_data)
}

# Function to test URL status
test_url <- function(url, timeout = 10) {
  tryCatch({
    response <- GET(url, timeout(timeout), user_agent("awesome-R URL Checker"))
    
    list(
      url = url,
      status_code = status_code(response),
      final_url = response$url,
      error = NA
    )
  }, error = function(e) {
    list(
      url = url,
      status_code = NA,
      final_url = NA,
      error = as.character(e)
    )
  })
}

# Main execution
cat("Extracting URLs from markdown files...\n")

# Files to check
files <- c(
  "README.md",
  "misc/posts.md", 
  "misc/r-trending.md"
)

# Extract all URLs
all_urls <- data.frame()
for (file in files) {
  file_urls <- extract_urls(file)
  all_urls <- rbind(all_urls, file_urls)
}

# Get unique URLs
unique_urls <- unique(all_urls$url)
cat(sprintf("Found %d total URLs, %d unique URLs\n", nrow(all_urls), length(unique_urls)))

# Test each unique URL
cat("Testing URLs...\n")
results <- list()

for (i in seq_along(unique_urls)) {
  url <- unique_urls[i]
  cat(sprintf("Testing %d/%d: %s\n", i, length(unique_urls), url))
  
  result <- test_url(url)
  results[[i]] <- result
  
  # Small delay to be respectful
  Sys.sleep(0.5)
}

# Convert results to data frame
results_df <- do.call(rbind, lapply(results, data.frame))

# Categorize results
results_df$category <- ifelse(
  is.na(results_df$status_code), "Dead",
  ifelse(results_df$status_code >= 200 & results_df$status_code < 400, "Working",
    ifelse(results_df$status_code >= 400, "Dead", "Unknown")))

# Check for redirects
results_df$redirected <- results_df$url != results_df$final_url

# Summary
cat("\n=== SUMMARY ===\n")
cat(sprintf("Working URLs: %d\n", sum(results_df$category == "Working")))
cat(sprintf("Dead URLs: %d\n", sum(results_df$category == "Dead")))
cat(sprintf("Redirected URLs: %d\n", sum(results_df$redirected, na.rm = TRUE)))

# Find which files contain dead URLs
cat("\n=== DEAD URLs ===\n")
dead_urls <- results_df[results_df$category == "Dead", ]

for (i in 1:nrow(dead_urls)) {
  dead_url <- dead_urls$url[i]
  locations <- all_urls[all_urls$url == dead_url, ]
  
  cat(sprintf("\n%s\n", dead_url))
  if (!is.na(dead_urls$error[i])) {
    cat(sprintf("  Error: %s\n", dead_urls$error[i]))
  } else {
    cat(sprintf("  Status: %s\n", dead_urls$status_code[i]))
  }
  
  for (j in 1:nrow(locations)) {
    cat(sprintf("  Found in: %s (line %d)\n", locations$file[j], locations$line[j]))
  }
}

# Redirected URLs
redirected <- results_df[results_df$redirected == TRUE & !is.na(results_df$redirected), ]
if (nrow(redirected) > 0) {
  cat("\n=== REDIRECTED URLs ===\n")
  for (i in 1:nrow(redirected)) {
    cat(sprintf("\n%s\n", redirected$url[i]))
    cat(sprintf("  Redirects to: %s\n", redirected$final_url[i]))
    
    locations <- all_urls[all_urls$url == redirected$url[i], ]
    for (j in 1:nrow(locations)) {
      cat(sprintf("  Found in: %s (line %d)\n", locations$file[j], locations$line[j]))
    }
  }
}

# Save detailed results
write.csv(results_df, "url_test_results.csv", row.names = FALSE)
write.csv(all_urls, "all_urls_with_locations.csv", row.names = FALSE)

cat("\n=== Results saved to url_test_results.csv and all_urls_with_locations.csv ===\n")