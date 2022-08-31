suppressMessages({
  memory.limit(size = 8000000)
  library(readxl)
  library(writexl)
  library(plyr)
  library(dplyr)
  library(data.table)
  library(zoo)
  library(shiny)
  library(shinydashboard)
  library(shinydashboardPlus)
  library(shinyWidgets)
  library(htmlwidgets)
  library(lubridate)
  library(tcltk)
  library(tidyverse)
  library(plotly)
  library(knitr)
  library(kableExtra)
  library(leaflet)
  library(grid)
  library(gridExtra)
  library(eeptools)
  library(ggQC)
  library(zipcodeR)
  library(utils)
  library(scales)
  library(chron)
  library(bupaR)
  library(shiny)
  library(DT)
  library(DiagrammeR)
  library(shinyalert)
  library(edeaR)
  library(processmapR)
  library(processmonitR)
  library(processanimateR)
  library(tidyr)
  library(lubridate)
  library(RColorBrewer)
  library(DiagrammeR)
  library(ggplot2)
  library(leaflet)
  library(readr)
  library(highcharter)
  library(ggforce) # for 'geom_arc_bar'
  library(packcircles) # for packed circle graph
  library(viridis)
  library(ggiraph)
  library(treemapify)
  library(treemap)
  library(broom)
  library(extrafont)
  library(tis) # for US holidays
  library(vroom)
  library(sjmisc)
  library(tools)
  library(here)
  library(shinyBS)
  library(shinyscreenshot)
  library(fasttime)
  library(shinycssloaders)
  library(feather)
  # library(zipcodeR)
  library(formattable)
  library(shinyjs)
  library(janitor)
  library(patchwork)
  library(flexdashboard)
  # library(tidyverse)
  # library(viridis)
  # library(hrbrthemes)
  # library(plotly)
  # install.packages("bsts")
  library(bsts)
  library(reactable)
  # install.packages("reactablefmtr")
  library(reactablefmtr)
  library(svDialogs)
  library(openxlsx)
  library(flextable)
  library(officedown)
  library(officer)
  library(magrittr)
  library(webshot) 
  library(png)
  library(ggh4x)
})

# Set variables for report
# reporting_year <- dlgInput("Enter Reporting Year")$res
# reporting_quarter <- toupper(dlgInput("Enter Reporting Year")$res)

quarter_start <- "2021-01-01"
quarter_end <- "2022-07-01"

quarters_list <- sort(unique(as.yearqtr(seq(from=as.Date(quarter_start) , to=floor_date(as.Date(quarter_end) -1 - months(1), "month"), by="month"))))

# reporting_date <- max((scheduling_data_raw %>% filter(Appt.Status == "Arrived") %>% filter(Appt.DateYear <= Sys.Date()))$Appt.DateYear)
reporting_year <- format(quarters_list[length(quarters_list)], "%Y") ## Create year column
reporting_YearQtr <<- quarters_list[length(quarters_list)]

data_quarters <- tail(quarters_list,5)

# Specify campuses to include
inc_sites <- c("NETWORK","MSM","MSH-MSDFP","ONCOLOGY","MSW","MSBI","MSUS","MSH- AMBULATORY CARE","MSDD")
specialty_list <- c("Anesthesiology/Pain Management", 
                 "Cardiovascular Institute/Cardiology", 
                 "Cardiovascular Surgery",
                 "Dermatology", 
                 # "Genetics & Genomic Sciences", 
                 "Geriatrics",
                 "Medicine - Clinical Immunology", 
                 "Medicine - Endocrinology",
                 "Medicine - Gastroenterology",
                 "Medicine - Infectious Diseases/Travel Medicine",
                 "Medicine - Liver",                              
                 "Medicine - Primary Care",
                 "Medicine - Pulmonary/Sleep",
                 "Medicine - Renal/Nephrology",
                 "Medicine - Rheumatology",
                 "Neurology",
                 "Neurosurgery",
                 "OB-GYN",
                 "Ophthalmology",
                 "Orthopedics",
                 "Otolaryngology",
                 # "Pathology",
                 "Pediatrics",
                 "Psychiatry",
                 # "Radiology",
                 "Rehabilitation and Human Performance",
                 "Surgery",
                 "Thoracic Surgery",
                 "Tisch Institute/Hematology Oncology",
                 "Transplant Institute",
                 # "Urgent Care",
                 "Urology")


## 1. Render Executive Summary -------------------------------------------------
rmarkdown::render(
  'Quarterly_Performance_Executive.Rmd', output_file = paste0(reporting_YearQtr,'_Performance Executive Summary','.html')
)


## 2. Render Specialty Summary 
for (i in specialty_list){
  specialty <- "Surgery"
  rmarkdown::render("Quarterly_Performance_Executive_Specialty.rmd", output_file = paste0(reporting_YearQtr, '_Performance Summary_',
                                                                                          gsub("/", "_", specialty), '.html'))    
}
