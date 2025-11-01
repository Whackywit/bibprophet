# Load the required package
if (!requireNamespace("DiagrammeR", quietly = TRUE)) {
  stop("The 'DiagrammeR' package is required. Install it with install.packages('DiagrammeR').")
}

library(DiagrammeR)

# Define the concept map using Graphviz DOT syntax
concept_map <- grViz("\
digraph {
  graph [layout = dot, rankdir = LR, nodesep = 1, ranksep = 1.2]

  node [shape = rect, style = filled, fontname = Helvetica, fontsize = 12, width = 2.8, height = 0.9]

  pd [label = 'Professional Development\n(Training & Online Learning)', fillcolor = '#7EAAD8']
  pw [label = 'Personal Wellness\n(Dietary Habits & Physical Activity)', fillcolor = '#E9C29C']
  ib [label = 'Involvement Balance\n(Psychological presence in roles)', fillcolor = '#E3A5C7']
  tb [label = 'Time Balance\n(Allocation of time across roles)', fillcolor = '#F3DF9B']
  sb [label = 'Satisfaction Balance\n(Perceived fulfillment in roles)', fillcolor = '#D3E6CF']
  js [label = 'Job Satisfaction', fillcolor = '#7EAAD8']

  {rank = same; pd pw}
  {rank = same; ib tb}

  pd -> ib [color = '#5B80B2']
  pd -> sb [color = '#5B80B2']
  pw -> tb [color = '#B97A3B']
  pw -> sb [color = '#B97A3B']
  ib -> sb [color = '#8F5A87']
  tb -> sb [color = '#B89F4F']
  sb -> js [color = '#5B80B2']
}
")

# Render the concept map in the R graphics device
concept_map
