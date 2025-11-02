# bibprophet

This repository now contains a small reproducible R example that shows how to
split a two-panel (faceted) ggplot into two standalone images.  The workflow is
captured in [`scripts/split_facets.R`](scripts/split_facets.R); it constructs a
sample data set, renders one plot per facet, and writes the results into the
`plots/` directory.

Run the script from an R session or via `Rscript`:

```r
Rscript scripts/split_facets.R
```

After execution you will find `plots/Efficiency__DEA.png` and
`plots/Pathway__AI.png` in the `plots/` folder, and if you run the script from an
interactive session (for example, inside RStudio) each plot is also printed to
the Plots viewer.  Replace the example data inside `split_facets.R` with your
own values to reproduce the behaviour with your figures.
