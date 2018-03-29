class BerkleeValencia::CLI
  def call
    puts ""
    puts "Hello! Berklee Valencia is Berklee College of Music's graduate campus located in Valencia, Spain."
    puts "Filled with the musicians, business moguls and technologists of today and tomorrow, there is a wealth of things to discover here."
    puts ""
    menu
    # list_news_or_programs
     #break out to news options or programs options
     #show chosen details
    goodbye
  end

  def menu
    puts "Would you like to see the latest news or are you interested in seeing what programs are on offer?"
    puts "If you're all set, you can just say goodbye and we will see you next time with the latest news from Berklee Valencia!"
    puts ""
    puts "1. Meet the people and read the latest news"
    puts "2. See the available Programs"
    puts ""
  end

  def list_news_or_programs
    input = gets.strip
    case input
    when "1"
      list_news
    when "2"
      list_news
    when "exit"
      list_news
    end
  end

  def goodbye
    puts "Hasta luego!"
  end
end
