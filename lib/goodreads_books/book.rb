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

  def self.find_all_by_year(awards_year)
    self.all.select { |book| book.awards_year == awards_year }
  end #-- self.find_all_by_year --

end
