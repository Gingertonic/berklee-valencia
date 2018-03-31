class BV::NEWS_ARTICLE
  @@categories
  @@articles
  @@matches

  def self.get_news_categories
    @@articles = BV::SCRAPER.scrape_news
    @@categories = []
    @@articles.each do |article|
      @@categories.push(article[:category])
    end
    @@categories.uniq!
  end

  def self.list_news_categories
    @@categories.each.with_index(1) do |category, i|
      puts "#{i}. #{category}"
    end
  end

  def self.list_news_articles(input)
    @@matches = @@articles.find_all {|article| article[:category] == @@categories[input.to_i-1]}
    @@matches.each.with_index(1) do |article, i|
        puts "#{i}: #{Formatter.wrap(article[:title])}"
        puts "  // Posted on #{article[:date]}"
        puts "#{Formatter.wrap(article[:excerpt])}"
        puts ""
        article[:i] = i
      end
  end

  def self.print_article(input)
    article = @@articles.find { |article| article[:i] == input.to_i }
    url = article[:url]
    article_extended = BV::SCRAPER.scrape_article(url)
    BV::PRINTER.print_article(article, article_extended)
  end

end
