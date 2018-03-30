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
    end

    puts ""
    puts "Other Programs"
    @@other_programs.each.with_index(@@grad_programs.length + 1) do |otherprogram, i|
      if otherprogram[:detail] != ""
        puts "#{i}: #{otherprogram[:name]} (#{otherprogram[:detail]})"
      else
        puts "#{i}: #{otherprogram[:name]}"
      end
    end
  end

  def self.print_article(input)
    # BerkleeValencia::SCRAPER.scrape_article(input)
    puts ""
    puts "Article title" # puts "#{article[:title]}"
    puts "By author       date" # puts "#{article[:author]}"      #{article[:date]}
    # border = ""
    # borderlength = article[:title].length
    # borderlength.times {border << "-"}
    puts "--------------------" # puts "#{border}"
    puts "body of article"
    puts ""
    puts "related link 1 name: http://blah.com"
    puts "related link 1 name: http://blah.com"
    puts "related link 1 name: http://blah.com"
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
