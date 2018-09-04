class GoodreadsBooks::Scraper
  attr_accessor :awards_year, :main_url

  BASE_URL = "https://www.goodreads.com"
  PAGE_URL = "/choiceawards"

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
    if !(choice_awards = find_by_year(awards_year))
       choice_awards = create(awards_year)
       choice_awards.scrape_books
    end
    find_by_year(choice_awards.awards_year)
  end #-- self.find_or_create_by_year --

  def self.find_by_year(awards_year = nil)
    all.detect { |r| r.awards_year == awards_year }
  end #-- self.find_by_year --

  def self.create(awards_year = nil)
    #choice_awards = new(awards_year)
    #choice_awards.save
    #replaced with one line of code below using .tap method
    choice_awards = new(awards_year).tap { |s| s.save }

    # if awards_year is missing from the url,
    # goodreads.com defaults to latest choice awards year
    # /best-books-#{latest awards year}"
    if awards_year == nil
      choice_awards.main_url = "#{BASE_URL}#{PAGE_URL}"
      doc = Nokogiri::HTML(open(choice_awards.main_url))
      choice_awards.awards_year = doc.css("head title").text.split(" ")[2].to_i
    else
      choice_awards.main_url = "#{BASE_URL}#{PAGE_URL}/best-books-#{awards_year}"
      choice_awards.awards_year = awards_year
    end

    choice_awards # return instance of scraper
  end #-- self.create --

  def scrape_books
    doc = Nokogiri::HTML(open(@main_url))

    # Category winners page
    doc.css(".category.clearFix").each do |category|
      cate_name = category.css("h4").text
      cate_url = category.css("a").attr("href").text
      cate_title = category.css("img").attr("alt").text

      # for each winner element, assemble the book_details hash
      book_details = {
        :awards_year => @awards_year,
        :category => cate_name,
        :title => cate_title,
        :cate_url => "#{BASE_URL}#{cate_url}"
      }

      GoodreadsBooks::Book.new_from_web_page(book_details)
    end

    #binding.pry
  end #-- scrape_books --

end
