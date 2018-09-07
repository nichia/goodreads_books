# GoodreadsBooks

Goodreads CLI data gem app is an app that lists the best books of Goodreads Choice Awards from Goodreads web page https://www.goodreads.com/choiceawards.

This app is the first project for Full stack web development curriculum at Flatiron School. The project requirements is to build a Ruby gem that provides a Command Line Interface (CLI) to an external data source. This CLI is an Object Oriented Ruby application. It accesses (scrapes) 'two levels' of data from Goodreads web page, first, providing user a list of the best book for each category of the awards year. User can then make a choice and get detailed information about their selected book, or enter a different awards year and get a list of the winning books from that chosen year. When in the detailed view of a book, user can select to open a link to Goodreads website to read the reviews/information of that book.

# Object Struture:

1) CLI
  Command Line Interface to prompt users on what they would like to view. Default to list choice awards winners from previous year. User can then choose to view in more details, each of the winning books. Or, users can choose to list books from another year (users can choose from 2010 to previous year)

2) Scraper
  Scrapes Goodreads choice awards winners for years starting from 2010.

3) Book
  Class to store the winning book details. Methods to list or display in more details, each of the books.
