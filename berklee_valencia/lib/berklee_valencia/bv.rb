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
    article_extended[:body].each do |paragraph|
      if paragraph.match(/-{3} /)
        puts " _________________________________________________________________________________________"
        puts "|----- Press any key to scroll to the next section or type 'menu' to see all options -----|"
        puts " ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
        input = gets.strip
        if input == "menu"
          return "abort mission!"
        end
      end
    puts "#{paragraph}"
    puts ""
    end
      #puts "body of article"
    # if css("strong") then puts space between and --- around
    puts ""
    article_extended[:related_links].each.with_index do |link|
      puts "#{link}"
    end
    # puts "related link 1 name: http://blah.com"
    # puts "related link 1 name: http://blah.com"
    # puts "related link 1 name: http://blah.com"
    2.times {puts ""}
  end

  def self.print_program(input)
    # BerkleeValencia::SCRAPER.scrape_program(input)
    puts ""
    puts "Program title"
    # border = ""
    # borderlength = program[:title].length
    # borderlength.times {border << "-"}
    puts "------------" # puts "#{border}"
    puts "Introduction"
    puts "------------"
    puts "  body of Intro"
    puts ""
    puts "------------------"
    puts "Program Highlights"
    puts "------------------"
    puts "highlight 1 name"
    puts "  highlight 1 body"
    puts "highlight 2 name"
    puts "  highlight 2 body"
    puts "highlight 3 name"
    puts "  highlight 3 body"
    puts ""
      puts "----------------------"
      puts "Who We Are Looking For"
      puts "----------------------"
      puts "who we are looking for body"
      puts ""
      puts "Ideal candidates heading one:"
      puts "1. ideal one"
      puts "2. ideal two"
      puts "3. ideal three"
      puts "Ideal candidates heading two:"
      puts "1. ideal one"
      puts "2. ideal two"
      puts "3. ideal three"
      puts ""
      puts "related link 1 name: http://blah.com"
      puts "related link 1 name: http://blah.com"
      puts "related link 1 name: http://blah.com"
      2.times {puts ""}
    end
end
