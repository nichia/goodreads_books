class GoodreadsBooks::Book
  attr_accessor :awards_year, :category, :title, :author, :vote, :description, :category_url, :url

  @@all = []

  def initialize(attributes)
    attributes.each do |attr_name, attr_value|
      self.send("#{attr_name}=", attr_value)
    end
  end #-- initialize --

  def self.new_from_web_page(book_hash)
    book = new(book_hash)
    book.save
  end #-- self.new_from_web_page --

  def self.all
    @@all
  end #-- self.all --

  def save
    self.class.all << self
  end #-- save --

  def self.all_by_year(awards_year)
    all.select { |book| book.awards_year == awards_year }
  end #-- find_by_year --

  def author
    get_book_details if !@author
    @author
  end #-- author --

  def vote
    get_book_details if !@vote
    @vote
  end #-- vote --

  def description
    get_book_details if !@description
    @description
  end #-- description --

  def url
    get_book_details if !@url
    @url
  end #-- url --

  def get_book_details
    GoodreadsBooks::Scraper.scrape_book_details(self)
  end #-- get_book_details --

end
