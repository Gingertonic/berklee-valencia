class BerkleeValencia::CLI
  def call
    puts ""
    puts "Buenos Dias! Berklee Valencia is Berklee College of Music's graduate campus located in Valencia, Spain."
    puts "Filled with the musicians, business moguls and technologists of today and tomorrow, there is a wealth of things to discover here."
    puts ""
    menu
  end

  def menu
    puts ""
    puts "Would you like to see the latest news or are you interested in seeing what programs are on offer?"
    puts "If you're all set, you can just say 'hasta luego' and we will see you next time with the latest news from Berklee Valencia!"
    puts ""
    puts "1. Meet the people and read the latest news"
    puts "2. See the available Programs"
    puts ""
    list_news_or_programs
  end

  def list_news_or_programs
    input = gets.strip.downcase
    puts ""
    if input == "1"
      BerkleeValencia::BV.list_news
      show_article
    elsif input == "2"
      BerkleeValencia::BV.list_programs
      show_program
    elsif input.match(/hasta luego|exit|bye|ciao/)
      goodbye
    else
      say_what
    end
  end

  def show_article
    input = gets.strip.downcase
    if input.to_i > 0
      BerkleeValencia::BV.print_article(input)
      what_next
    elsif input.match(/hasta luego|exit|bye|ciao/)
      goodbye
    else
      say_what
    end
  end

  def show_program
    input = gets.strip.downcase
    if input.to_i > 0
      BerkleeValencia::BV.print_program(input)
      what_next
    elsif input.match(/hasta luego|exit|bye|ciao/)
      goodbye
    else
      say_what
    end
  end

  def say_what
    puts "Sorry, I didn't understand that!"
    menu
  end

  def what_next
    puts ""
    puts "What would you like to do next?"
    puts "1. See news articles"
    puts "2. See programs"
    puts ""
    puts "If you're all set, you can just say 'hasta luego' and we will see you next time with the latest news from Berklee Valencia!"
    list_news_or_programs
  end

  def goodbye
    puts "Hasta luego!"
    puts ""
  end
end
