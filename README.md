
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dtreg

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/dtreg)](https://CRAN.R-project.org/package=dtreg)
[![Coverage
Status](https://coveralls.io/repos/github/OlgaLezhnina/dtreg_R/badge.svg?branch=master)](https://coveralls.io/github/OlgaLezhnina/dtreg_R?branch=master)
<!-- badges: end -->

The goal of dtreg is to help users interact with various data type
registries (DTRs) and create machine-readable data. Currently, we
support the [ePIC](https://fc4e-t4-3.github.io/) and
[ORKG](https://orkg.org/) DTRs.

- First, load a DTR schema (an ePIC datatype or an ORKG template) as an
  R object.

- Then, create a new instance of the schema by filling in the relevant
  fields.

- Finally, write the instance as a machine-readable JSON-LD file.

## Installation

The easiest way is to install dtreg from CRAN:

``` r
install.packages("dtreg")
```

### Development version

You can install the development version of dtreg with:

``` r
# install.packages("devtools")
library(devtools)
devtools::install_gitlab("TIBHannover/orkg/dtreg-r", build_vignettes = TRUE)
```

## Example

This brief example shows you how to work with a DTR schema. You need to
know the schema identifier (see the [help
page](https://orkg.org/help-center/article/47/reborn_articles) ). For
instance, the schema “data item” requires the ePIC datatype with the DOI
<https://doi.org/21.T11969/aff130c76e68ead3862e>. For the ORKG, please
use the ORKG template URL, such as <https://orkg.org/template/R758316>.

``` r
library(dtreg)
## load the schema with the known identifier
dt <- dtreg::load_datatype("https://doi.org/21.T11969/aff130c76e68ead3862e")
## look at the schemata you might need to use
names(dt)
#>  [1] "string"            "url"               "integer_in_string"
#>  [4] "column"            "cell"              "row"              
#>  [7] "table"             "component"         "matrix_size"      
#> [10] "figure"            "data_item"
## check available fields for your schema
dtreg::show_fields(dt$data_item())
#> [1] "comment"            "has_expression"     "has_characteristic"
#> [4] "has_part"           "source_table"       "source_url"        
#> [7] "label"
## create your own instance by filling the fields of your choice
## see the help page to know more about the fields
my_label = "my results"
my_df <- data.frame(A = 1, B = 2, stringsAsFactors = FALSE)
url_1 <- dt$url(label = "URL_1")
url_2 <- dt$url(label = "URL_2")
my_inst <- dt$data_item(
  label = my_label,
  has_expression = list(url_1, url_2),
  source_table = my_df
)
## write the instance in JSON-LD format as a string
my_json <- dtreg::to_jsonld(my_inst)

## the result can be saved as a JSON file
## write(my_json, "my_file.json")
```

For more information, please see the [help
page](https://orkg.org/help-center/article/47/reborn_articles) and dtreg
vignette. To access the vignette, you can run:

``` r
vignette("dtreg", package="dtreg")
```
