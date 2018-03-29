class BerkleeValencia::SCRAPER
bv_news = "https://valencia.berklee.edu/news/"
bv_programs = "https://valencia.berklee.edu/academic-programs/"

  def self.scrape_news
    news = Nokogiri::HTML(open(bv_news))
    articles = []
    news.css("div#news_container div.content").each_with_index do |article, i|
      articles << {
        index: i + 1,
        date: article.css("div.news_excerpt span.date").text,
        title: article.css("div.news_excerpt h3 a").text,
        url: article.css("div.news_excerpt h3 a").attribute("href").value,
        category: article.css("span.category_name").text
      }
    end
  end

  # def self.scrape_programs
  #   academics = Nokogiri::HTML(open(bv_programs))
  # end

end
