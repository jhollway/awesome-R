# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is the "Awesome R" repository - a curated list of awesome R packages and tools. It's a community-maintained resource that catalogs useful R packages, libraries, and tools across various categories like data manipulation, visualization, machine learning, web technologies, and more.

## Repository Structure

- `README.md` - The main curated list containing categorized R packages and resources (25,000+ tokens)
- `misc/` - Maintenance and automation scripts
  - `GHstarScraper.R` - Scrapes GitHub star counts and automatically adds star badges to popular packages (400+ stars)
  - `trending_repo.R` - Generates trending R repository reports by querying GitHub API
  - `posts.md` - Archive of posts and updates
  - `r-trending.md` - Generated markdown file with trending R repositories

## Key Maintenance Scripts

### Star Badge Automation (`misc/GHstarScraper.R`)
- Uses `rvest` and `purrr` to scrape GitHub star counts
- Automatically adds heart emoji badges to packages with 400+ stars
- Modifies README.md by pattern matching package names and adding badges
- Outputs to `README.md.new` for review before replacement

### Trending Repository Report (`misc/trending_repo.R`)
- Uses GitHub API to find trending R repositories (by language:r and topic:r)
- Generates both trending (last 30 days) and all-time popular repository lists
- Outputs markdown report to `r-trending.md`
- Maintains CSV data files for historical tracking

## Development Workflow

The repository follows a simple maintenance workflow:

1. **Manual curation**: New packages and resources are added manually to README.md
2. **Automated star tracking**: `GHstarScraper.R` periodically updates star badges for popular packages
3. **Trending reports**: `trending_repo.R` generates supplementary trending repository lists
4. **Review and merge**: Changes are reviewed before being incorporated

## Common Commands

Since this is a documentation repository, there are no build or test commands. The main operations are:

```bash
# Update star badges (run from repository root)
Rscript misc/GHstarScraper.R

# Generate trending report
Rscript misc/trending_repo.R

# Review changes before committing
git diff README.md
```

## Package Categories

The README.md is organized into major categories including:
- IDE integrations and syntax packages
- Data manipulation (dplyr, data.table, etc.)
- Visualization and graphics
- Web technologies and APIs  
- Machine learning and statistics
- Domain-specific packages (finance, bioinformatics, spatial, etc.)
- Learning resources and reference materials

When adding new packages, follow the existing categorization and formatting patterns. Include package descriptions and GitHub/CRAN links where available.