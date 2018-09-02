class GoodreadsBooks::CLI
  @scrape_year = 0

  def call(awards_year = nil)
    puts "Loading #{awards_year} Winners of Goodreads Choice Awards Books..."
    # find_or_create_by_year - initial with awards_year = nil
    winners = GoodreadsBooks::Scraper.find_or_create_by_year(awards_year)
    binding.pry
    main_menu(winners)
  end #-- call --

  def main_menu(winners)
    system "clear"

    input = nil
    while input != "exit"
      list_books(winners)

      puts ""
      puts "Enter a number to view details of the book, or"
      puts "select another Choice Awards year (2010 to previous year)."
      puts "You may enter 'exit' to end the application."
      input = gets.strip
      if input.downcase == "exit"
        puts ""
        puts "Thank you for using Goodreads Choice Awards Books."
      elsif input.to_i.between?(1, GoodreadsBooks::Book.all.count)
        book = GoodreadsBooks::Book.find_by_year_and_index(winners.awards_year, input.to_i - 1)
        view_book(winners, book)
      elsif input.to_i.between?(2010, Time.now.year - 1)
        call(input.to_i)
      else
        puts ""
        puts "I don't understand that answer."
      end
    end
  end #-- main_menu --

  def list_books(winners)
    binding.pry
    puts ""
    puts "#{winners.awards_year} Goodreads Choice Awards Books".colorize(:blue)
    puts ""

    GoodreadsBooks::Book.list_by_year(winners.awards_year).each.with_index(1) do |book, index|
      puts "#{index}. #{book.title} - #{book.author} - #{book.category}"
    end
  end #-- display_books --

  def view_book(winners, book)
    puts ""
    puts "---------- #{winners.awards_year} Best #{book.category} ----------"
    puts "Title:        #{book.title}"
    puts "Author:       #{book.author}"
    puts "Description:  #{book.description}"
    puts "Click url:    <%= auto_link(#{book.url}) %>"
  end #-- view_book --
end
