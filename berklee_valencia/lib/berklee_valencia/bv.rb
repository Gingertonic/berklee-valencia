class BerkleeValencia::BV
  @@categories
  @@articles
  @@matches

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
    grad_programs = BerkleeValencia::SCRAPER.scrape_graduate_programs
    other_programs = BerkleeValencia::SCRAPER.scrape_other_programs
    puts "--------------------------------------------------------------"
    puts "Enter the number of the program you'd like to read more about."
    puts "--------------------------------------------------------------"
    puts "Graduate Programs"
    grad_programs.each.with_index(1) do |gradprogram, i|
      if gradprogram[:detail] != ""
        puts "#{i}: #{gradprogram[:name]} (#{gradprogram[:detail]})"
      else
        puts "#{i}: #{gradprogram[:name]}"
      end
    end

    puts ""
    puts "Other Programs"
    other_programs.each.with_index(grad_programs.length + 1) do |otherprogram, i|
      if otherprogram[:detail] != ""
        puts "#{i}: #{otherprogram[:name]} (#{otherprogram[:detail]})"
      else
        puts "#{i}: #{otherprogram[:name]}"
      end
    end
  end

  def self.print_article(input)
    # BerkleeValencia::SCRAPER.scrape_article
    puts ""
    puts "You chose article #{input}"
  end

  def self.print_program(input)
    # BerkleeValencia::SCRAPER.scrape_program
    puts ""
    puts "Info on Program #{input}"
  end
end
