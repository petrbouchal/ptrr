
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ptrr

<!-- badges: start -->
<!-- badges: end -->

This is a package for personal utilities.

It contains:

-   RMarkdown templates and output formats
    -   document
    -   invoice
    -   xaringan presentation
-   `ggplot2` themes
-   `drat` utilities
-   `precommit` recipes
-   font import utilities
-   number, date and scale formatting functions
-   Rmd templates and related utilities for repo doc, xaringan slides,
    and Rmd webpage

## Installation

You can install the latest release of ptrr from
[Github](https://github.com) with:

``` r
devtools::install_github("petrbouchal/ptrr", ref = github_release())
```

The current development version is at

``` r
devtools::install_github("petrbouchal/ptrr")
```

There are also binaries in the `petrbouchal/drat` repo; this can be
installed with

``` r
install.packages("ptrr", repos = "https://petrbouchal.github.io/drat")
#> Installing package into '/Users/petr/Library/R/4.0/library'
#> (as 'lib' is unspecified)
#> installing the source package 'ptrr'
```

## TODO

-   rounding function
    <https://twitter.com/hspter/status/314858331598626816>
-   Czech scales
-   Czech units
