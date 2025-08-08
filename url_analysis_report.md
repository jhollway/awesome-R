# awesome-R Repository URL Analysis Report

Generated on: 2025-08-08

## Summary

This report analyzes all URLs found in the awesome-R repository's markdown files to identify potentially dead or broken links.

## Files Analyzed

1. `/home/runner/work/awesome-R/awesome-R/README.md` - Main repository documentation
2. `/home/runner/work/awesome-R/awesome-R/misc/posts.md` - Collection of R-related posts
3. `/home/runner/work/awesome-R/awesome-R/misc/r-trending.md` - Trending R repositories

## URL Categories Found

### 1. GitHub Repository URLs
These are generally reliable but should be checked for repository existence:
- Pattern: `https://github.com/username/repo`
- Examples from analysis:
  - `https://github.com/sindresorhus/awesome` (line 3, README.md)
  - `https://github.com/josephmisiti/awesome-machine-learning` (line 5, README.md)
  - `https://github.com/rstudio/gt` (line 58, README.md)

### 2. CRAN Package URLs
These follow a standard pattern and are usually stable:
- Pattern: `https://cran.r-project.org/web/packages/PACKAGE/index.html`
- Examples:
  - `https://cran.r-project.org/web/packages/lightgbm/index.html` (line 59, README.md)
  - `https://cran.r-project.org/web/packages/torch/index.html` (line 60, README.md)

### 3. Documentation/Website URLs
Various documentation sites that may be more prone to link rot:
- Examples:
  - `https://code.visualstudio.com/` (line 57, README.md)
  - `http://www.rstudio.org/` (line 72, README.md)
  - `http://ess.r-project.org/` (line 73, README.md)

### 4. Academic/Personal Blog URLs
These are most likely to become dead links:
- Examples from posts.md:
  - `http://blog.h2o.ai/2016/04/fast-csv-writing-for-r/` (line 8)
  - `http://md.ekstrandom.net/blog/2016/04/using-r/` (line 9)
  - `http://juliasilge.com/blog/How-I-Stopped/` (line 10)

## Potentially Problematic URL Patterns Identified

### High Risk for Link Rot

1. **Personal Blog URLs** (misc/posts.md):
   - `http://md.ekstrandom.net/blog/2016/04/using-r/` (line 9)
   - `http://juliasilge.com/blog/How-I-Stopped/` (line 10)
   - `http://f.local/r/sustainable-code-for-social-scientists` (line 23)
   - `http://f.local/r/string-manipulation-on-full-names` (line 27)

2. **Older Blog Posts and Articles**:
   - Multiple URLs from 2016-2017 timeframe in posts.md
   - Academic personal pages that may have changed

3. **Specific Concerning URLs**:
   - `http://f.local/` URLs (lines 23, 27 in posts.md) - These appear to be local/development URLs
   - `http://www1.cuni.cz/~obo/r_surprises.html` (line 35, posts.md) - Academic personal page

### Medium Risk

1. **Documentation Sites Without HTTPS**:
   - `http://www.rstudio.org/` (line 72, README.md) - Should likely be HTTPS
   - `http://ess.r-project.org/` (line 73, README.md)
   - `http://socserv.mcmaster.ca/jfox/Misc/Rcmdr/` (line 77, README.md)

2. **CDN URLs**:
   - `https://cdn.rawgit.com/sindresorhus/awesome/...` (line 3, README.md) - RawGit was deprecated
   - `https://cdn.jsdelivr.net/gh/qinwf/awesome-R@...` (multiple lines) - Should be stable

## Specific Recommendations

### Immediate Action Required

1. **Fix Local URLs in posts.md**:
   - Line 23: `http://f.local/r/sustainable-code-for-social-scientists` - Appears to be a local development URL
   - Line 27: `http://f.local/r/string-manipulation-on-full-names` - Same issue

### URLs to Verify

1. **Academic Personal Pages** (misc/posts.md):
   - Line 35: `http://www1.cuni.cz/~obo/r_surprises.html`
   - Various university personal pages that may have moved

2. **Deprecated Services**:
   - Line 3 (README.md): `https://cdn.rawgit.com/...` - RawGit service was shut down, recommend switching to jsDelivr

3. **HTTP vs HTTPS Migration**:
   - Many sites have migrated to HTTPS. Test and update:
     - `http://www.rstudio.org/` → likely `https://posit.co/` or `https://www.rstudio.com/`
     - `http://ess.r-project.org/` → check if HTTPS available

## Testing Methodology Recommendations

To properly validate these URLs, run the following checks:

1. **HTTP Status Check**: Verify each URL returns 200-399 status codes
2. **Redirect Following**: Check if URLs redirect and update to final destinations
3. **Content Validation**: Ensure the linked content is still relevant
4. **HTTPS Migration Check**: Test if HTTP URLs have HTTPS equivalents

## Maintenance Recommendations

1. **Regular Automated Checks**: Set up periodic URL validation (quarterly)
2. **Community Contribution Guidelines**: Ask contributors to verify URLs when adding new entries
3. **Wayback Machine Integration**: For important dead links, consider linking to archive.org versions
4. **Alternative Resource Suggestions**: For dead links, research and suggest current alternatives

## Summary Statistics

- **Total URLs Found**: Approximately 200+ URLs across all files
- **Highest Risk Files**: misc/posts.md (contains many 2016-era blog posts)
- **Most Stable URLs**: GitHub repositories and CRAN packages
- **Immediate Fixes Needed**: 2 f.local URLs in posts.md

## Next Steps

1. Test the specific URLs flagged as high-risk
2. Update or remove confirmed dead links
3. Consider implementing automated URL checking in CI/CD pipeline
4. Update documentation to prefer HTTPS URLs where available