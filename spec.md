# Specifications for the CLI Assessment

Specs:
- [x] Have a CLI for interfacing with the application
      # Users interact with a CLI to navigate the available data.
- [x] Pull data from an external source
      # App scrapes https://valencia.berklee.edu/news/ & https://valencia.berklee.edu/academic-programs/ to make    corresponding Article & Program instances.
- [X] Implement both list and detail views
      # User navigates through a series of menus which end in a detailed print out of either a news article or academic program information.

Menu Structure:

Welcome
|
Menu
|_____List of Article Categories
|      |
|      |_____List of  Articles in chosen Category
|            |
|            |_____Print of full Article
|                  |
|                  |_____'What next?' menu'
|
|_____List of Programs
      |
      |_____Print of full Program information
            |
            |_____'What next?' menu'
