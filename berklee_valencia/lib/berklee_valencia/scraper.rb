class BerkleeValencia::SCRAPER
@bv_news = "https://valencia.berklee.edu/news/"
@bv_programs = "https://valencia.berklee.edu/academic-programs/"

  def self.scrape_news
    news = Nokogiri::HTML(open(@bv_news))
    articles = []
    news.css("div#news_container div.content").each do |article|
      articles << {
        date: article.css("div.news_excerpt span.date").text,
        title: article.css("div.news_excerpt h3 a").text,
        excerpt: article.css("div.news_excerpt p").text,
        url: article.css("div.news_excerpt h3 a").attribute("href").value,
        category: article.css("span.category_name").text
      }
    end
    articles
  end

  # def self.scrape_programs
  #   academics = Nokogiri::HTML(open(bv_programs))
  # end

end
