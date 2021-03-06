class GoodreadsBooks::CLI

  # This application only works for year 2010 to latest awards year (usually, current year - 1).
  # Goodreads Choice Awards Winner 2009 page setup differs from 2010 onwards.
  BASE_YEAR = 2010

  def call
    system "clear"
    puts ""
    puts "---------- Welcome to Goodreads Choice Awards ----------"
    puts "           ----------------------------------"
    puts ""

    @latest_awards_year = GoodreadsBooks::Scraper.scrape_awards_year
    load_choice_awards_books(@latest_awards_year)

    main_menu
  end #-- call --

  def load_choice_awards_books(awards_year)
    @awards_year = awards_year
    puts "Loading The Goodreads Choice Awards Winners for #{awards_year} ..."
    if GoodreadsBooks::Book.find_all_by_year(awards_year).empty?
      GoodreadsBooks::Scraper.scrape_books(awards_year)
    end
  end #-- load_choice_awards_books --

  def main_menu
    valid_input = true
    input = nil
    while input != "exit"
      book_count = GoodreadsBooks::Book.find_all_by_year(@awards_year).count
      list_books

      puts ""
      if !valid_input
        puts "Please enter the book number to see more information:".colorize(:red)
        puts "(You can also enter another Choice Awards year of 2010 or later, or type 'exit')".colorize(:red)
        valid_input = true
      else
        puts "Please enter the book number to see more information:".colorize(:green)
        puts "(You can also enter another Choice Awards year of 2010 or later, or type 'exit')".colorize(:green)
      end

      input = gets.strip

      if input.downcase == "exit"
        break
      elsif input.to_i.between?(1, book_count)
        book = GoodreadsBooks::Book.find_all_by_year(@awards_year)[input.to_i - 1]
        if !book.author
          GoodreadsBooks::Scraper.scrape_book_details(book)
        end
        view_book(book)
      elsif input.to_i.between?(BASE_YEAR, @latest_awards_year)
        load_choice_awards_books(input.to_i)
      else
        valid_input = false
      end
    end

    puts ""
    puts "Thank you for using the Goodreads Choice Awards Application."
  end #-- main_menu --

  def list_books
    system "clear"
    puts ""
    puts "---------- #{@awards_year} Goodreads Choice Awards Winners----------"
    puts ""

    GoodreadsBooks::Book.find_all_by_year(@awards_year).each.with_index(1) do |book, index|
      puts "#{index}. #{book.category}: #{book.title}"
    end
  end #-- display_books --

  def view_book(book)
    system "clear"
    puts ""
    puts "---------- #{@awards_year} BEST #{book.category.upcase} Winner ----------"
    puts ""
    puts "Title:        #{book.title}"
    puts "Author:       #{book.author}"
    puts "Votes:        #{book.vote}"
    puts "Description:  #{book.description}"

    puts ""
    puts "Would you like to open Goodreads website to view this book? Enter Y to open the website.".colorize(:green)
    input = gets.strip.downcase

    if input.downcase == "y"
      system("open #{book.url}")
    end
  end #-- view_book --
end
