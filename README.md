
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dtreg

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/dtreg)](https://CRAN.R-project.org/package=dtreg)
<!-- badges: end -->

**100% AI-free: we did not use any AI technologies in developing this
package.**

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
devtools::install_gitlab("TIBHannover/lki/knowledge-loom/dtreg-r", build_vignettes = TRUE)
```

## Example

This brief example shows you how to work with a DTR schema. You need to
know the schema identifier (see the [help
page](https://knowledgeloom.tib.eu/pages/help) ).

``` r
library(dtreg)
## load the schema with the known identifier
dt <- dtreg::load_datatype("https://doi.org/21.T11969/aff130c76e68ead3862e")
## look at the schemata you might need to use
names(dt)
## check available fields for your schema
dtreg::show_fields(dt$data_item())
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
page](https://knowledgeloom.tib.eu/pages/help) and dtreg vignette. To
access the vignette, you can run:

``` r
vignette("dtreg", package="dtreg")
```
