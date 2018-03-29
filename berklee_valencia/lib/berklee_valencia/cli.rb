class BerkleeValencia::CLI
  def call
    puts ""
    puts "Hello! Berklee Valencia is Berklee College of Music's graduate campus located in Valencia, Spain."
    puts "Filled with the musicians, business moguls and technologists of today and tomorrow, there is a wealth of things to discover here."
    puts ""
    menu
    list_news_or_programs
    goodbye
  end

  def menu
    puts ""
    puts "Would you like to see the latest news or are you interested in seeing what programs are on offer?"
    puts "If you're all set, you can just say goodbye and we will see you next time with the latest news from Berklee Valencia!"
    puts ""
    puts "1. Meet the people and read the latest news"
    puts "2. See the available Programs"
    puts ""
  end

  def list_news_or_programs
    input = gets.strip.downcase
    puts ""
    case input
    when "1"
      # berklee.list_news
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
      show_article
    when "2"
      # berklee.list_programs
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
      show_program
    when "goodbye"
      exit!
    end
  end

  def show_article
    input = gets.strip.downcase
    puts ""
    puts "You chose article #{input}"
    puts ""
    puts "What would you like to do next?"
    puts "1. See news articles"
    puts "2. See programs"
    puts ""
    puts "If you're all set, you can just say goodbye and we will see you next time with the latest news from Berklee Valencia!"
    list_news_or_programs
  end

  def show_program
    input = gets.strip.downcase
    puts ""
    puts "Info on Program #{input}"
    puts ""
    puts "What would you like to do next?"
    puts "1. See news articles"
    puts "2. See programs"
    puts ""
    puts "If you're all set, you can just say goodbye and we will see you next time with the latest news from Berklee Valencia!"
    list_news_or_programs
  end

  def goodbye
    puts "Hasta luego!"
  end
end
