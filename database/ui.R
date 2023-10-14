# Define header
header <- shinydashboard::dashboardHeader(
  title = 'POC in Wildlife Ecology')

# Define sidebar 
sidebar <- shinydashboard::dashboardSidebar(
  # Define sidebarMenu
  sidebarMenu(
    menuItem('About', tabName = 'about'),
    menuItem('Database', tabName = 'database'),
    menuItem('Returning User', tabName = 'returning')
  )
)

# Define body
body <- shinydashboard::dashboardBody(
  # Link stylesheet
  includeCSS(here::here('database', 'www', 'styles.css')),
  # Define tabItems
  tabItems(
    # Add tabItem
    tabItem(tabName = 'about',
            # Add banner image
            tags$img(
              class = 'banner', 
              src = 'images/elephants.jpg'),
            # Define fluidRow
            fluidRow(
              column(width = 8,
                     # Add about text
                     box(width = NULL,
                         includeMarkdown(here::here(
                           'database', 'text', 'about.md'))
                         )),
              column(width = 4,
                     # Add join text
                     box(width = NULL,
                         includeMarkdown(here::here(
                           'database', 'text', 'join.md'))
                         ),
                     # Add edit text
                     box(width = NULL,
                         includeMarkdown(here::here(
                           'database', 'text', 'edit.md'))
                         ))
              )
            ),
    # Add tabItem
    tabItem(tabName = 'database',
            # Define fluidRow
            fluidRow(
              column(width = 4,
                     # Add career pickerInput
                     box(width = NULL, 
                         shinyWidgets::pickerInput('career', 
                                                   label = 'Select Career Stage:',
                                                   choices = unique(
                                                     users$`Current career stage`),
                                                   selected = unique(
                                                     users$`Current career stage`),
                                                   options = pickerOptions(
                                                     actionsBox = TRUE),
                                                   multiple = T)
                         )),
              column(width = 4,
                     # Add primary subfield pickerInput
                     box(width = NULL,
                         shinyWidgets::pickerInput('primary', 
                                                   label = 'Select Primary Subfield:',
                                                   choices = unique(
                                                     users$`Primary subfield`),
                                                   selected = unique(
                                                     users$`Primary subfield`),
                                                   options = pickerOptions(
                                                     actionsBox = TRUE),
                                                   multiple = T)
                         )),
              column(width = 4,
                     # Add secondary subfield pickerInput
                     box(width = NULL,
                         shinyWidgets::pickerInput('secondary', 
                                                   label = 'Select Secondary Subfield:',
                                                   choices = unique(na.omit(
                                                     users$`Secondary subfield`)),
                                                   selected = unique(na.omit(
                                                     users$`Secondary subfield`)),
                                                   options = pickerOptions(
                                                     actionsBox = TRUE),
                                                   multiple = T)
                         ))
              ),
            # Define fluidRow
            fluidRow(
              # Add reactive DataTable
              column(width = 12,
                     box(width = NULL,
                         DT::DTOutput('filterusers', width = '100%')
                         ))
              )
            ),
    # Add tabItem
    tabItem(tabName = 'returning',
            fluidRow(
              column(width = 12,
                     box(width = NULL,
                         includeMarkdown(here::here(
                           'database', 'text', 'instructions.md'))
                         ))
              ),
            # Define fluidRow
            fluidRow(
              # Add reactive editable DataTable
              column(width = 12,
                     box(width = NULL,
                         DTedit::dtedit_ui('editusers')
                         ))
              )
            )
    )
  )

# Define user interface
shinydashboard::dashboardPage(header, sidebar, body)