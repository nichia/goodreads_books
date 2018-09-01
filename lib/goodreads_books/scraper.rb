class GoodreadsBooks::Scraper

  def scrape_books
    base_url = "https://www.goodreads.com/choiceawards/"
    awards_year = Time.now.year - 1
    main_url = "#{base_url}best-books-#{awards_year}"
    doc = Nokogiri::HTML(open(main_url))

    binding.pry
  end #-- scrape_books --
end
