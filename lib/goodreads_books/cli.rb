class GoodreadsBooks::CLI

  def initialize
    @@choice_awards = nil
  end

  def call
    system "clear"
    puts ""
    puts "---------- Welcome to Goodreads Choice Awards Books ----------"
    puts "           ----------------------------------------"
    puts ""

    load_choice_awards

    main_menu
  end #-- call --

  def load_choice_awards(awards_year = nil)
    if awards_year == nil
      puts "Loading The Latest Winners of Goodreads Choice Awards Books..."
    else
      puts "Loading The Winners of #{awards_year} Goodreads Choice Awards Books..."
    end

    @choice_awards = GoodreadsBooks::Scraper.find_or_create_by_year(awards_year)
  end #-- load_choice_awards --

  def main_menu
    system "clear"

    input = nil
    while input != "exit"
      list_books

      puts ""
      puts "Enter a number to view details of the book, or select another Choice Awards year (2010 onwards)."
      puts "Type 'exit' to end the application."
      input = gets.strip

      if input.downcase == "exit"
        break
      elsif input.to_i.between?(1, GoodreadsBooks::Book.all_by_year(@choice_awards.awards_year).count)
        book = GoodreadsBooks::Book.all_by_year(@choice_awards.awards_year)[input.to_i - 1]
        view_book(book)

      elsif input.to_i.between?(2010, Time.now.year - 1)
        # This application only works for year 2010 to current year - 1.
        # Goodreads Choice Awards Winner 2009 page setup differs from 2010 onwards.
        load_choice_awards(input.to_i)
      else
        puts ""
        puts "I don't understand that answer.".colorize(:red)
      end
    end

    puts ""
    puts "Thank you for using Goodreads Choice Awards Books."
  end #-- main_menu --

  def list_books
    puts ""
    puts "---------- #{@choice_awards.awards_year} Goodreads Choice Awards Books ----------"
    puts ""

    GoodreadsBooks::Book.all_by_year(@choice_awards.awards_year).each.with_index(1) do |book, index|
      puts "#{index}. #{book.category}: #{book.title}"
      #puts "#{index}. #{book.category}: #{book.title} - #{book.author}"
    end
  end #-- display_books --

  def view_book(book)
    puts ""
    puts "---------- #{@choice_awards.awards_year} BEST #{book.category.upcase} Winner - #{book.vote} votes----------"
    puts "Title:        #{book.title}"
    puts "Author:       #{book.author}"
    puts "URL:          #{book.url}"
    puts "---------- Description ----------"
    puts "#{book.description}"

    puts ""
    puts "Would you like to visit Goodreads website to view this book? Enter Y or N".colorize(:blue)
    input = gets.strip.downcase

    if input.downcase == "y"
      system("open #{book.url}")
    end
  end #-- view_book --
end
