class GoodreadsBooks::Scraper
  BASE_URL = "https://www.goodreads.com"
  PAGE_URL = "/choiceawards"

  def self.scrape_awards_year
    # if awards_year is missing from the url,
    # goodreads.com defaults to latest choice awards year
    # /best-books-#{latest awards year}"
    main_url = "#{BASE_URL}#{PAGE_URL}"
    html = open(main_url)
    html.base_uri.to_s.split("-").last.to_i
  end #-- self.scrape_awards_year

  def self.scrape_books(awards_year)
    main_url = "#{BASE_URL}#{PAGE_URL}/best-books-#{awards_year}"
    doc = Nokogiri::HTML(open(main_url))

    # Category winners page: iterate through the best book of each category and collect the book information
    doc.css(".category.clearFix").collect do |category|
      category_name = category.css("h4").text
      category_url = category.css("a").attr("href").text
      category_title = category.css("img").attr("alt").text

      # for each winner element, assemble the book_details hash
      book_details = {
        :awards_year => awards_year,
        :category => category_name,
        :title => category_title,
        :category_url => "#{BASE_URL}#{category_url}"
      }

      GoodreadsBooks::Book.new_from_web_page(book_details)
    end
  end #-- self.scrape_books --

  def self.scrape_book_details(book)
    # Next level of scraping (get details of best book within each category_url)
    book_doc = Nokogiri::HTML(open(book.category_url))

    book.vote = book_doc.css(".gcaRightContainer .gcaWinnerHeader").text.split(" ")[1]
    book.author = book_doc.css(".gcaRightContainer h3 .gcaAuthor a.authorName").text
    book.url = "#{BASE_URL}#{book_doc.css(".gcaRightContainer h3 a.winningTitle").attr("href").text}"

    # goodreads description is encoded, so need to add .encode("ISO-8859-1") to print the special characters eg. â\u0080\u0099s in printable character of '
    # if self.awards_year < 2017, use the span tag, else there's no span tag so don't check for it
    description = book_doc.css(".gcaRightContainer .readable.stacked span")[1]
    if description
      book.description = book_doc.css(".gcaRightContainer .readable.stacked span")[1].text.encode("ISO-8859-1")
    else
      book.description = book_doc.css(".gcaRightContainer .readable.stacked").text.encode("ISO-8859-1")
    end
  end #-- self.scrape_book_details --

end
