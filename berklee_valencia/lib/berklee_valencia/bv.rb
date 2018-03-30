class BerkleeValencia::BV
  @@categories
  @@articles
  @@matches
  @@grad_programs
  @@other_programs

#First lines of this can refactor to initialize method
#Convert methods and variables to instance
#Call BV.new early in CLI
  def self.list_news_categories
    @@articles = BerkleeValencia::SCRAPER.scrape_news
    @@categories = []

    @@articles.each do |article|
      @@categories.push(article[:category])
    end

    @@categories.uniq!

    puts "--------------------------------------------"
    puts "Which kind of article are you interested in?"
    puts "--------------------------------------------"
    @@categories.each.with_index(1) do |category, i|
      puts "#{i}. #{category}"
    end
  end

  def self.list_news_articles(input)
    @@matches = @@articles.find_all {|article| article[:category] == @@categories[input.to_i-1]}
    @@matches.each.with_index(1) do |article, i|
        puts "#{i}: #{article[:title]} // Posted on #{article[:date]}"
        puts "      #{article[:excerpt]}"
        puts ""
        article[:i] = i
      end
  end


  def self.list_programs
    # programs = BerkleeValencia::SCRAPER.scrape_programs
    @@grad_programs = BerkleeValencia::SCRAPER.scrape_graduate_programs
    @@other_programs = BerkleeValencia::SCRAPER.scrape_other_programs
    puts "--------------------------------------------------------------"
    puts "Enter the number of the program you'd like to read more about."
    puts "--------------------------------------------------------------"
    puts "Graduate Programs"
    @@grad_programs.each.with_index(1) do |gradprogram, i|
      if gradprogram[:detail] != ""
        puts "#{i}: #{gradprogram[:name]} (#{gradprogram[:detail]})"
      else
        puts "#{i}: #{gradprogram[:name]}"
      end
      gradprogram[:i] = i
    end

    puts ""
    puts "Other Programs"
    @@other_programs.each.with_index(@@grad_programs.length + 1) do |otherprogram, i|
      if otherprogram[:detail] != ""
        puts "#{i}: #{otherprogram[:name]} (#{otherprogram[:detail]})"
      else
        puts "#{i}: #{otherprogram[:name]}"
      end
      otherprogram[:i] = i
    end
  end

  def self.print_article(input)
    article = @@articles.find { |article| article[:i] == input.to_i }
    url = article[:url]
    article_extended = BerkleeValencia::SCRAPER.scrape_article(url)
    border = ""
    if article[:title].length < (article_extended[:author].length + article[:date].length)
      borderlength = article_extended[:author].length + article[:date].length + 5
      borderlength.times {border << "-"}
    else
      borderlength = article[:title].length
      borderlength.times {border << "-"}
    end
    puts ""
    puts "#{border}"
    puts "#{border}"
    puts "#{article[:title]}" #puts "Article title" #
    gap = ""
    if border.length > article[:title].length
      5.times {gap << " "}
    else
      (article[:title].length - article_extended[:author].length - article[:date].length).times {gap << " "}
    end
    puts "#{article_extended[:author]}#{gap}#{article[:date]}"      #{article[:date]}puts "By author       date"
    puts "#{border}"
    puts "#{border}"
    # binding.pry
    article_extended[:body].each do |paragraph|
      if paragraph.match(/-{3} /)
        puts "___________________________________________________"
        puts " ||  Press enter to scroll to the next section  ||"
        puts " ||      or type 'menu' to see all options      ||"
        puts "‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
        input = gets.strip
        if input == "menu"
          return "abort mission!"
        end
      end
    puts "#{paragraph}"
    # binding.pry
    if paragraph.match(/[:]$/)
        puts "    Vist #{article_extended[:related_links].shift}"
      if paragraph.match(/below/)
        puts "    Vist #{article_extended[:related_links].shift}"
      end
    end
    puts ""
    end
      #puts "body of article"
    # if css("strong") then puts space between and --- around
    puts ""
    puts "____________________________________________________"
    puts " ||                END OF ARTICLE                ||"
    puts "‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
    # puts "related link 1 name: http://blah.com"
    # puts "related link 1 name: http://blah.com"
    # puts "related link 1 name: http://blah.com"
    2.times {puts ""}
  end

  def self.print_program(input)
    programs = @@grad_programs
    @@other_programs.each { |program| programs << program }
    program = programs.find { |program| program[:i] == input.to_i }
    url = program[:url]
    program_extended = BerkleeValencia::SCRAPER.scrape_program(url)
    # BerkleeValencia::SCRAPER.scrape_program(input)
    puts ""
    puts "#{program[:name]}"
    if program[:detail] != ""
      puts "  (#{program[:detail]})"
    end
    # border = ""
    # borderlength = program[:title].length
    # borderlength.times {border << "-"}
    puts "------------" # puts "#{border}"
    puts "Introduction"
    puts "------------"
    puts "#{program_extended[:introduction]}"
    puts ""
    puts "------------------"
    puts "Program Highlights"
    puts "------------------"
    program_extended[:highlights].each do |highlight|
      # binding.pry
      puts "#{highlight[:hl_title]}"
      puts "    #{highlight[:hl_body]}"
      puts ""
    end
    # binding.pry
    if program_extended[:ideals_heading]
      if program_extended[:ideals_heading].downcase.match(/ideal/)
        puts "#{program_extended[:ideals_heading]}"
      end
    end
    # binding.pry
    program_extended[:ideals].each do |li|
      puts ">  #{li}"
    end
    puts ""
    puts "For full program information, vist #{program[:url]}"
      2.times {puts ""}
    end
end
