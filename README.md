
<!-- README.md is generated from README.Rmd. Please edit that file -->

# sourrr

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/sourrr)](https://CRAN.R-project.org/package=sourrr)
<!-- badges: end -->

Use {sourrr} to generate sourdough bread recipes using [baker’s
percentages](https://www.theperfectloaf.com/reference/introduction-to-bakers-percentages/).

## Installation

You can install the development version of {sourrr} from github with:

``` r
# install.packages("remotes")
remotes::install_github("andrewheiss/sourrr")
```

## Example

Suppose you want to bake a 75% hydration loaf that weighs 900 grams
using 100% hydration sourdough starter (i.e. you feed it a 1:1 ratio of
flour and water). Use the `build_recipe()` function to generate the
appropriate recipe:

``` r
library(sourrr)
build_recipe(final_weight = 900, hydration = 0.75)
#> 450g flour (514.3g total; 64.3g from starter)
#> 321g water (385.7g total; 64.3g from starter)
#> 129g starter (25%; 100% hydration)
#> 10g salt (2%)
#> ---
#> 75% hydration
#> 910g final loaf
```

You can set all the arguments:

``` r
build_recipe(final_weight = 900, hydration = 0.90,
             pct_starter = 0.25, starter_hydration = 1,
             pct_salt = 0.02)
#> 414g flour (473.7g total; 59.2g from starter)
#> 367g water (426.3g total; 59.2g from starter)
#> 118g starter (25%; 100% hydration)
#> 9g salt (2%)
#> ---
#> 90% hydration
#> 909g final loaf
```

For now, it’s not 100% correct because I add the salt to the final loaf
weight. The math is too tricky and I can’t figure it out right now with,
like, the ongoing global pandemic :shrug:.

If you have an existing recipe, you can use the `calculate_recipe()`
function to determine the hydration level:

``` r
calculate_recipe(flour = 450,  water = 320,
                 starter = 100, starter_hydration = 1, salt = 8)
#> 450g flour (500g total; 50g from starter)
#> 320g water (370g total; 50g from starter)
#> 100g starter (20%; 100% hydration)
#> 8g salt (1.6%)
#> ---
#> 74% hydration
#> 878g final loaf
```
