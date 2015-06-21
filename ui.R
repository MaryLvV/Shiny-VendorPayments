# library(shiny)
# library(dplyr)
# # Load, clean, and store the data
# Payments2012_full <- read.csv(url("http://tn.gov/opengov/downloadFiles/vendor_payments_2012_all.csv"), header = TRUE, quote = "", 
#                               row.names = NULL)
# Payments2013_full <- read.csv(url("http://tn.gov/opengov/downloadFiles/vendor_payments_2013_all.csv"), header = TRUE, quote = "", 
#                               row.names = NULL)
# Payments2014_full <- read.csvurl(("http://tn.gov/opengov/downloadFiles/vendor_payments_2014_all.csv"), header = TRUE, quote = "", 
#                               row.names = NULL)
# 
# FY2012 <- subset(Payments2012_full, select= c(Agency, Total.Annual.Expenditure.by.Program ))
# FY2013 <- subset(Payments2013_full, select= c(Agency, Total.Annual.Expenditure.by.Program ))
# FY2014 <- subset(Payments2014_full, select= c(Agency, Total.Annual.Expenditure.by.Program ))
# 
# byFY2012 <- group_by(FY2012, Agency)
# TotalFY2012 <- summarise(byFY2012, Total = sum(Total.Annual.Expenditure.by.Program))
# 
# byFY2013 <- group_by(FY2013, Agency)
# TotalFY2013 <- summarise(byFY2013, Total = sum(Total.Annual.Expenditure.by.Program))
# 
# byFY2014 <- group_by(FY2014, Agency)
# TotalFY2014 <- summarise(byFY2014, Total = sum(Total.Annual.Expenditure.by.Program))
# 
# TotalFY2012$fiscalYear <- "2012"
# TotalFY2013$fiscalYear <- "2013"
# TotalFY2014$fiscalYear <- "2014"
# 
# allFY <- bind_rows(TotalFY2012, TotalFY2013, TotalFY2014)
# colnames(allFY) <- c("Agency", "Total", "Fiscal.Year")
# 
# allFY$Fiscal.Year <- as.factor(allFY$Fiscal.Year)
# allFY$Total <- paste("$", formatC(allFY$Total,format="f", digits= 0, big.mark = ","), sep = "") 
# allFY$Agency[allFY$Agency < "a"] <- "(protected vendor payments)" 
# save(allFY, file = "allFY.Rda")

# Define the overall UI
library(shiny)
options(shiny.deprecation.messages=FALSE)
load("data/allFY.Rda")
shinyUI(
      fluidPage( 
            titlePanel("Vendor Payments in Tennessee"),
            # data inputs
            fluidRow(
                     column(12, tags$p("",tags$strong("About the Data"),""),
                                   tags$p("The data for this app comes from Transparent Tennessee -- http://www.tn.gov/opengov -- the 
                                   state of Tennessee’s open government site.  A fiscal year in Tennessee runs from July 1 – June 30.  
                                   FY2015 is the current fiscal year.  It will end on 6/30/2015. The full fiscal year files for 
                                   FY2012, FY2013, and FY2014 were summarized by agency and totaled for each of the three fiscal years.  
                                   Payments that are categorized as 'protected vendor payments' are primarily payments related to TennCare."),  
                                   tags$p("",tags$strong("How to Use the App"),""),
                                   tags$p("Select an agency using the ‘Agency’ dropdown to compare that agency’s spending over the three fiscal years.  
                                   A single fiscal year may be viewed by selecting it in the ‘Fiscal.Year’ dropdown.")
                                    )
            ),
                    
             fluidRow(
                      column(4, 
                         selectInput("agency", 
                                     "Agency:", 
                                     c("All", 
                                       unique(as.character(allFY$Agency))))
                        ),
                      column(4, 
                         selectInput("FY", 
                                     "Fiscal Year:", 
                                     c("All", 
                                       unique(as.character(allFY$Fiscal.Year))))
                        )
                  
            ),
            #output row 
            fluidRow(
                  column(12,
                         dataTableOutput(outputId="table")
                  )
            )    
      )            
)



































