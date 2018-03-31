class BV::SCRAPER
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

  def self.scrape_programs(type)
    type == "grad" ? academics = Nokogiri::HTML(open(@bv_programs)).css("div.col-3-5").first : academics = Nokogiri::HTML(open(@bv_programs)).css("div.col-3-5").last
    programs = []
    academics.css("ul a").each do |program|
      programs << {
        name: program.text,
        detail: program.css("span").text,
        url: program.attribute("href").value
      }
    end
    programs
  end

  def self.scrape_article(url)
    article = Nokogiri::HTML(open(url))
    extended_info = {
      author: article.css("span.author").text,
      related_links: [],
      body: []
    }
    sort_content(article, extended_info)
  end

  def self.sort_content(article, extended_info)
    article.css("div#tab_intro p").each do |para|
      if para.css("iframe").length == 0 && para.css("em").text.length < 30 && para.css("strong").text == "" && !para.text.match(/•/)
        extended_info[:body] << para.text
      elsif para.css("strong").text != ""
        extended_info[:body] << " --- #{para.text} ---"
      elsif para.css("em").text != ""
        comment = "#{para.text}"
        extended_info[:body] << " - - - - - - - - - - - - - - - - - Media - - - - - - - - - - - - - - - - - - -"
        extended_info[:body] << comment
        extended_info[:body] << " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
      elsif para.css("iframe").length > 0
       extended_info[:related_links] << para.css("iframe").attribute("src").value
      end
    end
    extended_info
  end

  def self.scrape_program(url)
    program = Nokogiri::HTML(open(url, :allow_redirections => :all))
    extended_info = {
      highlights: [],
      list: []
    }
    scrape_program_intro(program, extended_info)
    scrape_program_highlights(program, extended_info)
  end

  def self.scrape_program_intro(program, extended_info)
    # scrape intro
    if program.css("div#tab_intro p").first.text.length > 0
      extended_info[:introduction] = program.css("div#tab_intro p").first.text
    elsif program.css("div#tab_intro h4").length > 0
      extended_info[:introduction] = program.css("div#tab_intro h4").first.text
    else
      intro = program.css("div#tab_intro p").detect {|p| p.text.length > 150}
      extended_info[:introduction] = intro.text
    end
  end

  def self.scrape_program_highlights(program, extended_info)
    program.css("div#tab_intro div.block_content").each do |highlight|
      hl_title = highlight.css("p.block_content_item_title").text
      hl_body = highlight.css("div.bk_txt").text
      # extended_info[:highlights].send("\"#{hl_title.to_sym}\"=>", hl_body)
      extended_info[:highlights] << {
        hl_title: hl_title,
        hl_body: hl_body
      }
    end
    extended_info
  end


end
