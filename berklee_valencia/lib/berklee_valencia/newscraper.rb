class BerkleeValencia::SCRAPER
  @@bv_news = "https://valencia.berklee.edu/news/"
  @@bv_programs = "https://valencia.berklee.edu/academic-programs/"

  def self.make_programs
    course_types = Nokogiri::HTML(open(@@bv_programs)).css("div.col-3-5")
    course_types.each do |type|
      type.css("ul a").each do |program|
        attributes = {
          title: program.text,
          subtitle: program.css("span").text,
          url: program.attribute("href").value,
          type: type.css("h4").text
        }
      BerkleeValencia::PROGRAM.new_from_scraper(attributes)
      end
    end
  end

  def self.make_articles
    articles = Nokogiri::HTML(open(@@bv_news))
    articles.css("div#news_container div.content").each do |article|
      attributes = {
        title: article.css("div.news_excerpt h3 a").text,
        category: article.css("span.category_name").text,
        date: article.css("div.news_excerpt span.date").text,
        excerpt: article.css("div.news_excerpt p").text,
        url: article.css("div.news_excerpt h3 a").attribute("href").value
      }
      BerkleeValencia::ARTICLE.new_from_scraper(attributes)
    end
  end

  def self.get_article_extended_info(url)
    article = Nokogiri::HTML(open(url))
    extended_info = {
      author: article.css("span.author").text,
      related_links: [],
      body: []
    }
    sort_content(article, extended_info)
    extended_info
  end

  def self.get_program_extended_info(url)
    program = Nokogiri::HTML(open(url, :allow_redirections => :all))
    extended_info = {
      introduction: "",
      highlights: []
    }
    scrape_program_intro(program, extended_info)
    scrape_program_highlights(program, extended_info)
    extended_info
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

  def self.scrape_program_intro(program, extended_info)
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
      extended_info[:highlights] << {
        hl_title: hl_title,
        hl_body: hl_body
      }
    end
  end

end #class
