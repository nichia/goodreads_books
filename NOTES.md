# GoodreadsBooks

Goodreads CLI gem is a command line application that lists the yearly Goodreads Choice Awards books. The application will list the latest winning books from Goodreads website https://www.goodreads.com/choiceawards.

Users have the option to :
1) enter a corresponding number to view details of a book. This displays the associated details of the book and user can choose to open up a Goodreads website link to read up more details/reviews of the book, or go back to the previous menu listing.
2) enter a different year to view a list of that year's choice award winning books which will be listed as in option (1).
3) exit the application.

Object structures of the application will include a Goodreads CLI to interface with the user, a Scraper to scrape Goodreads website of the book details and a Book class to store and methods to access each of the books extracted.

# Object Struture: 

1) CLI
  Command Line Interface to prompt users on what they would like to view. Default to list choice awards winners from previous year. User can then choose to view in more details, each of the winning books. Or, users can choose to list books from another year (users can choose from 2010 to previous year)

2) Scraper
  Scrapes Goodreads choice awards winners for years starting from 2010.

3) Book
  Class to store the winning book details. Methods to list or display in more details, each of the books.
