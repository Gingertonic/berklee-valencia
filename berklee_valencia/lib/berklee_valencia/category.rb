class BerkleeValencia::CATEGORY
  attr_accessor :title, :i, :articles

  @@all = []

  def initialize(title)
    @title = title
    @articles = []
    @@all << self
  end

  def self.find_by_title(title)
    @@all.detect {|cat| cat.title == title}
  end

  def self.find_or_create_from_article(article)
    # binding.pry
    if find_by_title(article.category)
      find_by_title(article.category).articles << article
    else
      self.new(article.category).tap {|cat| cat.articles << article}
    end
  end

  def self.find_cat_by_index(input)
    all.detect{|cat| cat.i == input.to_i}
  end

  def find_article_by_index(input)
    @articles.detect{|article| article.i == input.to_i}
  end

  def self.index_categories
    # binding.pry
    @@all.each.with_index(1) {|cat, i| cat.i = i}
  end

  def index_articles
    @articles.each.with_index(1) {|article, i| article.i = i}
  end

  def self.all
    @@all
  end

end
