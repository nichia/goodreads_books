class GoodreadsBooks::CLI

  # This application only works for year 2010 to current year - 1.
  # Goodreads Choice Awards Winner 2009 page setup differs from 2010 onwards.
  BASE_YEAR = 2010
  END_YEAR = Time.now.year - 1

  def call
    system "clear"
    puts ""
    puts "---------- Welcome to Goodreads Choice Awards Books ----------"
    puts "           ----------------------------------------"
    puts ""

    load_choice_awards_books

    main_menu
  end #-- call --

  def load_choice_awards_books(awards_year = nil)
    if awards_year == nil
      puts "Loading The Latest Winners of Goodreads Choice Awards Books..."
      books = GoodreadsBooks::Scraper.scrape_books
      # set @awards_year to the awards_year first the first book
      @awards_year = books[1].awards_year
    else
      @awards_year = awards_year
      puts "Loading The Winners of #{awards_year} Goodreads Choice Awards Books..."
      if GoodreadsBooks::Book.all_by_year(awards_year).empty?
        books = GoodreadsBooks::Scraper.scrape_books(awards_year)
      end
    end
  end #-- load_choice_awards_books --

  def main_menu
    input_valid = true
    input = nil
    while input != "exit"
      book_count = GoodreadsBooks::Book.all_by_year(@awards_year).count

      list_books
      if !input_valid
        input_valid = true
        puts ""
        puts "Please enter a number between 1 and #{book_count} or a valid Choice Awards year".colorize(:red)
      end

      puts ""
      puts "Enter a number to view details of the book, or select another Choice Awards year (2010 onwards).".colorize(:green)
      puts "Type 'exit' to end the application.".colorize(:green)
      input = gets.strip

      if input.downcase == "exit"
        break
      elsif input.to_i.between?(1, book_count)
        book = GoodreadsBooks::Book.all_by_year(@awards_year)[input.to_i - 1]
        if !book.author
            GoodreadsBooks::Scraper.scrape_book_details(book)
        end
        view_book(book)
      elsif input.to_i.between?(BASE_YEAR, END_YEAR)
        load_choice_awards_books(input.to_i)
      else
        input_valid = false
      end
    end

    puts ""
    puts "Thank you for using Goodreads Choice Awards Books."
  end #-- main_menu --

  def list_books
    puts ""
    puts "---------- #{@awards_year} Goodreads Choice Awards Books ----------"
    puts ""

    GoodreadsBooks::Book.all_by_year(@awards_year).each.with_index(1) do |book, index|
      puts "#{index}. #{book.category} - #{book.title}"
    end
  end #-- display_books --

  def view_book(book)
    puts ""
    puts "---------- #{@awards_year} BEST #{book.category.upcase} Winner ----------"
    puts ""
    puts "Title:        #{book.title}"
    puts "Author:       #{book.author}"
    puts "Votes:        #{book.vote}"
    puts ""
    puts "       --- Description ---"
    puts "#{book.description}"

    puts ""
    puts "Would you like to open Goodreads website to view this book? Enter Y to open the website.".colorize(:green)
    input = gets.strip.downcase

    if input.downcase == "y"
      system("open #{book.url}")
    end
  end #-- view_book --
end
