class BerkleeValencia::CATEGORY
  attr_accessor :title, :i, :articles

  @@all = []

  def initialize(title)
    @title = title
    @articles = []
    self.i = @@all.length + 1
    @@all << self
  end

  def self.find_by_title(title)
    @@all.detect {|cat| cat.title == title}
  end

  def self.find_or_create_from_article(article)
    if find_by_title(article.category)
      find_by_title(article.category).articles << article
    else
      self.new(article.category).articles << article
    end
  end

  def self.find_cat_by_index(input)
    all.detect{|cat| cat.i == input.to_i}
    # Any point in changing to all[input.to_i - 1] ?
  end

  def find_article_by_index(input)
    @articles.detect{|article| article.i == input.to_i}
    # Any point in changing @articles[input.to_i - 1] ?
  end

  def index_articles
    @articles.each.with_index(1) {|article, i| article.i = i}
  end

  def self.all
    @@all
  end

end
