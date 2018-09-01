class GoodreadsBooks::CLI

  def call
    puts "Loading Goodreads Choice Awards Winners..."
    books = GoodreadsBooks::Scraper.new
    books.scrape_books

  end #-- call --

  
end
