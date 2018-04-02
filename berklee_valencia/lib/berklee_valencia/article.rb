class BerkleeValencia::ARTICLE < BerkleeValencia::ITEM
  attr_accessor :date, :excerpt, :category, :author, :related_links, :body, :i
  @@all = []

  def self.new_from_scraper(attribute_hash)
    BerkleeValencia::ARTICLE.new(attribute_hash[:title], attribute_hash[:url]).tap do |article|
      article.category = attribute_hash[:category]
      article.date = attribute_hash[:date]
      article.excerpt = attribute_hash[:excerpt]
      @@all << article
      BerkleeValencia::CATEGORY.find_or_create_from_article(article)
    end
  end

  def extended_info_from_scraper(attribute_hash)
    @author = attribute_hash[:author]
    @related_links = attribute_hash[:related_links]
    @body = attribute_hash[:body]
  end

  def self.all
    @@all
  end

end
