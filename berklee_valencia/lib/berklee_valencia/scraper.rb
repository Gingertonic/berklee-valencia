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

  def self.scrape_graduate_programs
    academics = Nokogiri::HTML(open(@bv_programs))
    graduate_programs = []
    academics.css("div.col-3-5").first.css("ul a").each do |program|
      graduate_programs << {
          name: program.text,
          detail: program.css("span").text,
          url: program.attribute("href").value
      }
    end
    graduate_programs
  end

  def self.scrape_other_programs
    academics = Nokogiri::HTML(open(@bv_programs))
    other_programs = []
    academics.css("div.col-3-5").last.css("ul a").each do |program|
      other_programs << {
          name: program.text,
          detail: program.css("span").text,
          url: program.attribute("href").value
      }
    end
    other_programs
  end

  def self.scrape_article(i)
  end

  def self.scrape_program(input)
  end

end
