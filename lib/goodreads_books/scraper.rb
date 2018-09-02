class GoodreadsBooks::Scraper
  attr_accessor :awards_year, :main_url

  BASE_URL = "https://www.goodreads.com"

  @@all = []

  def initialize(awards_year = nil)
    @awards_year = awards_year
  end #-- initialize --

  def self.all
    @@all
  end #-- self.all --

  def save
    self.class.all << self
  end #-- save --

  def self.find_or_create_by_year(awards_year = nil)
    #self.find_by_year(awards_year) || create(awards_year)
    if !(scraped = find_by_year(awards_year))
       scraped = create(awards_year)
       scraped.scrape_books
    end
    find_by_year(scraped.awards_year)
  end #-- self.find_or_create_by_year --

  def self.find_by_year(awards_year = nil)
    all.detect { |r| r.awards_year == awards_year }
  end #-- self.find_by_year --

  def self.create(awards_year = nil)
    scraped = new(awards_year)
    scraped.save

    # new(awards_year).tap { |s| s.save }

    awards_page = "/choiceawards"

    # if awards_year is missing from the url,
    # goodreads.com defaults to latest choice awards
    # /best-books-#{latest awards year}"
    if awards_year == nil
      scraped.main_url = "#{BASE_URL}#{awards_page}"
      doc = Nokogiri::HTML(open(scraped.main_url))
      scraped.awards_year = doc.css("head title").text.split(" ")[2].to_i
    else
      scraped.main_url = "#{BASE_URL}#{awards_page}/best-books-#{awards_year}"
      scraped.awards_year = awards_year
    end

    scraped # return instance of scraper
  end #-- self.create --

  def scrape_books
    #base_url = "https://www.goodreads.com"
    # awards_year = Time.now.year - 1
    # defaults to latest choice awards #/best-books-#{awards_year}"
    #awards_page = "/choiceawards"
    #main_url = "#{base_url}#{awards_page}"

    doc = Nokogiri::HTML(open(@main_url))

    # Category winners page
    doc.css(".category.clearFix").each do |category|
      cate_name = category.css("h4").text
      cate_url = category.css("a").attr("href").text

      #cate_title = category.css("img").attr("alt").text
      #cate_book_id = category.css("input")[2].attr("value")
      # don't need to keep book_id

      # is self.scrape_book_details(cate_url) more appropriate?
      details = scrape_book_details("#{BASE_URL}#{cate_url}")

      # for each winner element, return the book_details hash
      book_details = {
        :awards_year => @awards_year,
        :category => cate_name,
        :title => details[:title],
        :author => details[:author],
        :description => details[:description],
        :url => "#{BASE_URL}#{details[:book_url]}"
      }

      GoodreadsBooks::Book.new_from_web_page(book_details)
    end
    binding.pry
  end #-- scrape_books --

  private
    def scrape_book_details(url)
      # Next level of scraping (get details of winner book within each category_url)
      book_doc = Nokogiri::HTML(open(url))

      #binding.pry
      details = {
        :author => book_doc.css(".gcaRightContainer h3 .gcaAuthor a.authorName").text,
        :title => book_doc.css(".gcaRightContainer h3 a.winningTitle").text,
        :book_url => book_doc.css(".gcaRightContainer h3 a.winningTitle").attr("href").text,
        :description => book_doc.css(".gcaRightContainer .readable.stacked").text.strip
      }
    end #-- scrape_book_details --

end
