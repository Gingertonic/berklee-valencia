require 'pry'
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

#CURRENTLY WORKING ON
  def self.scrape_article(url)
    # binding.pry
    article = Nokogiri::HTML(open(url))
    extended_info = {
      author: article.css("span.author").text,
      related_links: [],
      body: []
    }

    # if program.css("div#tab_intro ol").length > 0
    #   program.css("div#tab_intro ol").css("li").each do |li|
    #     extended_info[:list] << li.text
    #   end
    # end

    article.css("div#tab_intro p").each do |para|
      if para.css("iframe").length == 0 && para.css("em").text.length < 30 && para.css("strong").text == "" && !para.text.match(/•/)
        extended_info[:body] << para.text
      elsif para.css("strong").text != ""
        extended_info[:body] << "--- #{para.text} ---"
      elsif para.css("em").text != ""
        header = "#{para.text}"

    # article.css("div#tab_intro").each do |element|
    #   if element.css("p").length > 0 && element.css("p iframe").length == 0 && element.css("p em").text.length < 30 && element.css("p strong").text == ""
    #     extended_info[:body] << element.css("p").text
    #   elsif element.css("ol").length > 0
    #     extended_info[:body] << element.css("ol li").text
    #   elsif element.css("strong").text != ""
    #     extended_info[:body] << "--- #{element.text} ---"
    #   elsif element.css("p em").text != ""
    #     header = "#{element.text}"

        extended_info[:body] << " - - - - - - - - - - - Media - - - - - - - - - - -"
        extended_info[:body] << header
        extended_info[:body] << " - - - - - - - - - - - - - - - - - - - - - - - - -"
      elsif para.css("iframe").length > 0
       extended_info[:related_links] << para.css("iframe").attribute("src").value
      end
    end
    extended_info
  end

  def self.scrape_program(url)
    program = Nokogiri::HTML(open(url, :allow_redirections => :all))
    extended_info = {
      # introduction: program.css("div#tab_intro p").first.text,
      highlights: [], #array of key-value pairs hl_title: hl_body
      list: [] #[ideal1, ideal2, ideal3]
    }
    # binding.pry


    if program.css("div#tab_intro p").first.text.length > 0
      extended_info[:introduction] = program.css("div#tab_intro p").first.text
    elsif program.css("div#tab_intro h4").length > 0
      extended_info[:introduction] = program.css("div#tab_intro h4").first.text
    else
      intro = program.css("div#tab_intro p").detect {|p| p.text.length > 150}
      extended_info[:introduction] = intro.text
    end

    program.css("div#tab_intro div.block_content").each do |highlight|
      hl_title = highlight.css("p.block_content_item_title").text
      hl_body = highlight.css("div.bk_txt").text
      # extended_info[:highlights].send("\"#{hl_title.to_sym}\"=>", hl_body)
      extended_info[:highlights] << {
        hl_title: hl_title,
        hl_body: hl_body
      }
    end

    if program.css("div#tab_intro p strong").length > 0
      # binding.pry
      extended_info[:ideals_heading] = program.css("div#tab_intro p strong").first.text
    end

    if program.css("div#tab_intro ul").first.css("li strong").length > 0
      program.css("div#tab_intro ul").first.css("li").each do |li|
        extended_info[:list] << li.text
      end
    end



    extended_info
  end

end
