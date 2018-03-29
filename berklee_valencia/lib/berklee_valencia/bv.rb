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
    puts "Enter the number of the program you'd like to read more about."
    puts "Graduate Programs"
      puts "  1"
      puts "  2"
      puts "  3"
      puts "  ..."
    puts "Other Programs"
      puts "  1"
      puts "  2"
      puts "  3"
      puts "  ..."
      puts ""
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
