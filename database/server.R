server <- function(input, output){
  
  # Define reactive function
  filter_users <- shiny::reactive({
    users %>%
      # Add career stage pickerInput filter
      dplyr::filter(`Current career stage` %in% input$career) %>%
      # Add primary subfield pickerInput filter
      dplyr::filter(`Primary subfield` %in% input$primary) %>%
      # Add secondary subfield pickerInput filter
      dplyr::filter(`Secondary subfield` %in% input$secondary)
  })
  
  # Define reactive dataTable
  output$filterusers <- DT::renderDataTable({
    DT::datatable(filter_users(), rownames = FALSE,
                  options = list(paging = TRUE, 
                                 pageLength = 5,
                                 columnDefs = 
                                   list(list(targets = c(1:16), width = '5em')),
                                 autoWidth = TRUE,
                                 scrollX = TRUE))
  })
  
  
  my.insert.callback <- function(data, row){
    # Append row to data frame
    myusers <- rbind(data, myusers)
    return(myusers)
  }
  
  my.update.callback <- function(data, olddata, row){
    # Update row in data frame
    myusers[row,] <- data[1,]
    return(myusers)
  }
  
  my.delete.callback <- function(data, row){
    # Delete row in data frame
    myusers <- myusers[-row,]
    return(myusers)
  }
  
  # Create DTedit object
  DTedit::dtedit_server(
    id = 'editusers',
    thedata = myusers,
    view.cols = names(myusers)[c(1:2, 5:6)],
    edit.cols = names(myusers)[c(1:2)],
    edit.label.cols = names(myusers)[c(1:2)],
    input.types = myinputs,
    callback.update = my.update.callback,
    callback.insert = my.insert.callback,
    callback.delete = my.delete.callback)
}