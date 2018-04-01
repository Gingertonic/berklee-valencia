require 'pry'
class BerkleeValencia::ARTICLE < BerkleeValencia::ITEM
  attr_accessor :date, :excerpt, :category, :author, :related_links, :body, :i
  @@categories = []

  def self.new_from_scraper(attribute_hash)
    new_article = BerkleeValencia::ARTICLE.new(attribute_hash[:title], attribute_hash[:url])
    new_article.category = attribute_hash[:category]
    new_article.date = attribute_hash[:date]
    new_article.excerpt = attribute_hash[:excerpt]
    @@all << new_article
    @@categories << new_article.category
  end

  def extended_info_from_scraper(attribute_hash)
    @author = attribute_hash[:author]
    @related_links = attribute_hash[:related_links]
    @body = attribute_hash[:body]
  end

  def self.categories
    @@categories.uniq
  end

  def self.find_by_category(input)
    @@all.find_all {|article| article.category == @@categories[input.to_i - 1]}
  end

  def self.find_by_index(input)
    @@all.find {|article| article.i == input.to_i}
  end

  def self.reset_i
    @@all.each {|article| article.i == nil}
  end
end
