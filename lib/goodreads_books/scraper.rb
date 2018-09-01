class GoodreadsBooks::Scraper

  def scrape_books
    base_url = "https://www.goodreads.com"
    awards_year = Time.now.year - 1
    awards_page = "/choiceawards/best-books-#{awards_year}"
    main_url = "#{base_url}#{awards_page}"
    doc = Nokogiri::HTML(open(main_url))

    d1 = doc.css(".category.clearFix").first
    category = d1.css("h4").text
    title = d1.css("img").attr("alt").text
    url = d1.css("a").attr("href").text
    book_id = d1.css("input")[2].attr("value")
binding.pry
    category_url = "#{base_url}#{url}"
    cat_doc = Nokogiri::HTML(open(category_url))

    binding.pry

    n=cat_doc.css("h3")
    n_url=n.css("a").attr("href").text

    bdoc = Nokogiri::HTML(open("#{base_url}#{n_url}"))
    binding.pry
    #https://www.goodreads.com/choiceawards/best-fiction-books-2017
    #https://www.goodreads.com/book/show/34273236-little-fires-everywhere?from_choice=true

    #https://www.goodreads.com/choiceawards/best-mystery-thriller-books-2017
    #https://www.goodreads.com/book/show/33151805-into-the-water?from_choice=true

  end #-- scrape_books --


end
