
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dtreg

<!-- badges: start -->
<!-- badges: end -->

The goal of dtreg is to help the user interact with various data type
registries (DTRs). Currently, the ePIC and the ORKG DTRs are supported.
The user can load a DTR schema as an R object and create their own
instance of the schema. This instance can be written as a
machine-actionable JSON-LD file.

## Installation

You can install the development version of dtreg from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("OlgaLezhnina/dtreg")
```

## Example

This example shows you how to work with a schema from a DTR; you need to
know the identifier (URL) of the schema. The schema we use as an example
belongs to the ePIC DTR with DOI
“<https://doi.org/21.T11969/74bc7748b8cd520908bc>”. For the ORKG, please
use a template URL, such as
“<https://incubating.orkg.org/template/R855534>”.

``` r
library(dtreg)
## load the datatype schema you need
dt <- dtreg::load_datatype("https://doi.org/21.T11969/74bc7748b8cd520908bc")
## look at schemata to select the one(s) you intend to use
names(dt)
#> [1] "string"                  "url"                    
#> [3] "integer_in_string"       "column"                 
#> [5] "cell"                    "row"                    
#> [7] "table"                   "inferential_test_output"
## check available fields for your schema
dtreg::show_fields(dt$inferential_test_output())
#> [1] "has_format"      "comment"         "has_description" "label"
## create your own instance by filling the fields of your choice
my_inst <- dt$inferential_test_output(label = "my_results")
## write the instance in JSON-LD format
my_json <- dtreg::to_jsonld(my_inst)
```

For more information, please see XXX.
