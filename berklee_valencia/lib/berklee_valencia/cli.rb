class BerkleeValencia::CLI
  def call
    puts ""
    puts "||"
    puts "||"
    puts "||   /||    Buenos Dias!"
    puts "||  //||"
    puts "|| // ||    Berklee Valencia is Berklee College of Music's"
    puts "||//  ||        graduate campus located in Valencia, Spain"
    puts "||/   ||"
    puts "||    ||            Filled with the"
    puts "||   /||                musicians"
    puts "||  //||                  business moguls"
    puts "|| // ||                      and technologists"
    puts "||//  ||                    of today and tomorrow..."
    puts "||/   ||"
    puts "      ||      ...there is a wealth of things to discover here!"
    puts "      ||"
    menu
  end

  def menu
    puts ""
    puts "          Would you like to see the latest news or are you"
    puts "          interested in seeing what programs are on offer?"
    2.times {puts ""}
    puts "       1. Meet the people and read the latest news"
    puts "       2. See the available Programs"
    puts ""
    list_news_or_programs
  end

  def list_news_or_programs
    input = gets.strip.downcase
    if input.match(/hasta luego|exit|bye|ciao/)
      goodbye
    else
      puts ""
      puts "    Please be patient whilst we get up to date with all our news!"
      puts ""
      puts "        ...                    ...                    ..."
      puts ""
      if input == "1"
        show_news_categories
      elsif input == "2"
        show_programs
      elsif input == "programs"
        what_next
      else
        say_what
      end
    end
  end

  def list_news_articles
    puts ""
    input = gets.strip.downcase
    if input.to_i > 0
      puts ""
      puts "----------------------------------------------------------"
      puts "Enter the number of the article you'd like to read in full"
      puts "           or type 'menu' to see all options"
      puts "----------------------------------------------------------"
      BerkleeValencia::NEWS_ARTICLE.list_news_articles(input)
      show_article
    elsif input == "programs"
      show_programs
    else
      say_what
    end
  end

  def show_news_categories
    BerkleeValencia::NEWS_ARTICLE.get_news_categories
    puts ""
    puts "----------------------------------------------"
    puts " Which kind of article are you interested in?"
    puts "  Type 'programs' to browse programs instead"
    puts "----------------------------------------------"
    BerkleeValencia::NEWS_ARTICLE.list_news_categories
    list_news_articles
  end

  def show_programs
    BerkleeValencia::PROGRAM.get_programs
    puts ""
    puts "----------------------------------------------------------------"
    puts " Enter the number of the program you'd like to read more about"
    puts "     or type 'news' to browse our latest news and articles."
    puts "----------------------------------------------------------------"
    puts "Graduate Programs"
    BerkleeValencia::PROGRAM.list_programs("grad")
    puts ""
    puts "Other Programs"
    BerkleeValencia::PROGRAM.list_programs("other")
    show_program
  end

  def show_article
    puts ""
    input = gets.strip.downcase
    if input.to_i > 0
      if BerkleeValencia::NEWS_ARTICLE.print_article(input) == "abort mission!"
        menu
      else
        what_next
      end
    elsif input == "menu"
      what_next
    else
      say_what
    end
  end

  def show_program
    puts ""
    input = gets.strip.downcase
    if input.to_i > 0
      BerkleeValencia::PROGRAM.print_program(input)
      what_next
    elsif input == "news"
      show_news_categories
    else
      say_what
    end
  end

  def say_what
    puts ""
    puts "Sorry, I didn't understand that!"
    what_next
  end

  def what_next
    puts ""
    puts "What would you like to do next?"
    puts "1. See news articles"
    puts "2. See programs"
    puts ""
    puts "  If you're all set, you can just say ciao for now and we will "
    puts "  see you next time with the latest news from Berklee Valencia!"
    puts ""
    list_news_or_programs
  end


  def goodbye
    puts ""
    puts "Hasta luego!"
    puts ""
  end
end
