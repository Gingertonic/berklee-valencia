class BerkleeValencia::BV
  def self.list_news
    # articles = BerkleeValencia::SCRAPER.scrape_news
    puts "Enter the number of the article you'd like to read more about."
    puts "Alumni Profiles"
      puts "  1"
      puts "  2"
      puts "  3"
      puts "  ..."
    puts "Student Profiles"
      puts "  1"
      puts "  2"
      puts "  3"
      puts "  ..."
    puts "News"
      puts "  1"
      puts "  2"
      puts "  3"
      puts "  ..."
      puts ""
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
