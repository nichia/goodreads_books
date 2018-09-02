class GoodreadsBooks::Book
  attr_accessor :awards_year, :category, :title, :author, :description, :url

  @@all = []

  def initialize(attributes)
    attributes.each do |attr_name, attr_value|
      self.send("#{attr_name}=", attr_value)
    end
  end #-- initialize --

  def self.new_from_web_page(book_hash)
    #puts "#{self.all.count} - #{book_hash}"
    #binding.pry
    book = new(book_hash)
    book.save
  end #-- self.new_from_web_page --

  def self.all
    @@all
  end #-- self.all

  def save
    self.class.all << self
  end #-- save --

  def self.all_by_year(awards_year)
    all.select { |book| book.awards_year == awards_year }
  end #-- find_by_year --

  def self.find_by_year_and_index(awards_year, index)
    books = all_by_year(awards_year)
    books[index]
  end #-- find_by_year_and_index --
end
