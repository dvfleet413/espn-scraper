class Article
  attr_reader :title, :description, :url, :content
  @@all = []

  def initialize(title, description, url)
    @title = title
    @description = description
    @url = url
    @@all << self
  end

  def self.all
    @@all
  end

end
