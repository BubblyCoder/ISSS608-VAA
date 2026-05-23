
pacman::p_load(plotly, crosstalk, DT, 
               ggdist, ggridges, colorspace,
               gganimate, tidyverse,skimr,visNetwork)

# 1. Define the Processing Steps (Nodes)
process_nodes <- data.frame(
  id = 1:6,
  label = c("Mendeley CSV\n(Semicolon Delimited)", 
            "Initial Import\n(read_csv2)", 
            "Type Correction\n(liability_premium)", 
            "Feature Engineering\n(Risk Groups)", 
            "Cleaned Motor\nDataset",
            "Exploratory Data\nAnalysis (EDA)"),
  color = c("#BDBDBD", "#F7941D", "#F7941D", "#F7941D", "#00AEEF", "#8DC63F"),
  shape = c("database", "box", "box", "box", "box", "ellipse"),
  level = c(1, 2, 3, 4, 5, 6)
)

# 2. Define the Transitions (Edges)
process_edges <- data.frame(
  from = c(1, 2, 3, 4, 5),
  to   = c(2, 3, 4, 5, 6),
  label = c("Load File", "as.numeric()", "mutate()", "Final Clean", "ggplot2 / gganimate")
)

visNetwork(process_nodes, process_edges, 
           main = "Data Processing Pipeline: Motor Insurance Portfolio",
           submain = "Visualizing the ETL Process from Raw Data to Analytics") %>%
  
  # Styling the Nodes
  visNodes(font = list(face = "Segoe UI", size = 20), 
           shadow = TRUE, 
           borderWidth = 2) %>%
  
  # Styling the Edges (The "Tableau Prep" Look)
  visEdges(arrows = "to", 
           color = list(color = "darkgrey", highlight = "orange"),
           smooth = list(type = "curvedCW", roundness = 0.4), # Curves like the image
           font = list(align = "top", size = 14)) %>%
  
  # Forcing the Hierarchical Layout
  visHierarchicalLayout(direction = "LR", 
                        levelSeparation = 300, 
                        nodeSpacing = 150) %>%
  
  # Enable zooming and dragging for your Quarto readers
  visInteraction(hover = TRUE, 
                 navigationButtons = TRUE, 
                 multiselect = TRUE) %>%
  
  # Add a Legend
  visLegend(main = "Step Type", position = "right", ncol = 1)


# to add more nodes
# Example of branching logic
new_nodes <- data.frame(id = 7, label = "Claim Severity Analysis", level = 6)
new_edges <- data.frame(from = 5, to = 7, label = "Filter Claims > 0")
