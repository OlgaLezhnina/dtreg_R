
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dtreg

<!-- badges: start -->
<!-- badges: end -->

The goal of dtreg is to help the users interact with various data type
registries (DTRs) and create machine-readable data. Currently, we
support the [ePIC](https://fc4e-t4-3.github.io/) and the
[ORKG](https://orkg.org/) DTRs.

- First, load a DTR schema (an ePIC datatype or an ORKG template) as an
  R object.

- Then, create a new instance of the schema by filling in the relevant
  fields.

- Finally, write the instance as a machine-readable JSON-LD file.

## Installation

You can install the development version of dtreg from
[GitHub](https://github.com/) (TODO CRAN) with:

``` r
# install.packages("devtools")
devtools::install_github("OlgaLezhnina/dtreg")
```

## Example

This brief example shows you how to work with a DTR schema. You need to
know the schema identifier (see the [help
page](https://orkg.org/help-center/article/47/reborn_articles) ). For
instance, the schema “inferential test output” requires the ePIC
datatype with the DOI <https://doi.org/21.T11969/74bc7748b8cd520908bc>.
For the ORKG, please use the ORKG template URL, such as
<https://incubating.orkg.org/template/R855534>.

``` r
library(dtreg)
## load the schema with the known identifier
dt <- dtreg::load_datatype("https://doi.org/21.T11969/74bc7748b8cd520908bc")
## look at the schemata you might need to use
names(dt)
#> [1] "string"                  "url"                    
#> [3] "integer_in_string"       "column"                 
#> [5] "cell"                    "row"                    
#> [7] "table"                   "inferential_test_output"
## check available fields for your schema
dtreg::show_fields(dt$inferential_test_output())
#> [1] "has_format"      "comment"         "has_description" "label"
## create your own instance by filling the fields of your choice
## see the help page to know more about the fields
my_label = "my results"
my_df <- data.frame(A = 1, B = 2, stringsAsFactors = FALSE)
url_1 <- dt$url(label = "URL_1")
url_2 <- dt$url(label = "URL_2")
my_inst <- dt$inferential_test_output(label = my_label,
                                      has_description = c(url_1, url_2),
                                      has_format = my_df)
## write the instance in JSON-LD format
my_json <- dtreg::to_jsonld(my_inst)
```

For more information, please see the [help
page](https://orkg.org/help-center/article/47/reborn_articles) and the
dtreg vignette. To access the vignette, you can run:

``` r
vignette("dtreg", package="dtreg")
```
