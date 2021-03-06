class BerkleeValencia::CLI

  def call
    puts ""
    puts "||"
    puts "||"
    puts "||   /||    Buenos Días!"
    puts "||  //||"
    puts "|| // ||    Berklee Valencia is Berklee College of Music's"
    puts "||//  ||        graduate campus located in Valencia, Spain"
    puts "||/   ||"
    puts "||    ||            Filled with the"
    puts "||   /||                musicians,"
    puts "||  //||                  business moguls,"
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
    programs_or_news
  end

  def programs_or_news
    input = gets.strip.downcase
    if input.to_i.between?(1,2)
      please_wait
      # case statement chosen over if statement for easy future extension
      case input
      when "1"
        list_article_categories
      when "2"
        list_programs
      end
    else
      if_not_that_then_this(input)
    end
  end

  def list_article_categories
    # if statement used so scrape only happens when necessary
    # (it is necessary when a) a user wishes to view the articles and
    # b) the articles have not already been scraped)
    if BerkleeValencia::ARTICLE.all == []
      BerkleeValencia::SCRAPER.make_articles
    end
    puts ""
    puts "----------------------------------------------"
    puts " Which kind of article are you interested in?"
    puts "  Type 'programs' to browse programs instead"
    puts "----------------------------------------------"
    BerkleeValencia::PRINTER.print_article_categories
    input = gets.strip.downcase
    if input.to_i.between?(1,BerkleeValencia::CATEGORY.all.length)
      list_articles(input)
    elsif input == "programs"
      list_programs
    else
      if_not_that_then_this(input)
    end
  end

  def list_articles(input)
    puts ""
    puts "----------------------------------------------------------"
    puts "Enter the number of the article you'd like to read in full"
    puts "           or type 'menu' to see all options"
    puts "----------------------------------------------------------"
    category = BerkleeValencia::CATEGORY.find_cat_by_index(input)
    category.index_articles
    BerkleeValencia::PRINTER.print_articles_list(category)
    input = gets.strip.downcase
    if input.to_i.between?(1,category.articles.length)
      show_article(category, input)
    else
      if_not_that_then_this(input)
    end
  end

  def show_article(category, input)
    article = category.find_article_by_index(input)
    if !article.body
      attributes = BerkleeValencia::SCRAPER.get_article_extended_info(article.url)
      article.extended_info_from_scraper(attributes)
    end
    BerkleeValencia::PRINTER.print_article(article)
    what_next
  end

  def list_programs
    if BerkleeValencia::PROGRAM.all == []
      BerkleeValencia::SCRAPER.make_programs
    end
    puts ""
    puts "----------------------------------------------------------------"
    puts " Enter the number of the program you'd like to read more about"
    puts "     or type 'news' to browse our latest news and articles."
    puts "----------------------------------------------------------------"
    BerkleeValencia::PRINTER.print_programs_list
    input = gets.strip.downcase
    if input.to_i.between?(1,BerkleeValencia::PROGRAM.all.length)
      show_program(input)
    elsif input == "news"
      list_article_categories
    else
      if_not_that_then_this(input)
    end
  end

  def show_program(input)
    program = BerkleeValencia::PROGRAM.find_by_index(input.to_i)
    if !program.introduction
      attributes = BerkleeValencia::SCRAPER.get_program_extended_info(program.url)
      program.extended_info_from_scraper(attributes)
    end
    BerkleeValencia::PRINTER.print_program(program)
    what_next
  end

  def please_wait
    puts ""
    puts "    Please be patient whilst we get up to date with all our news!"
    puts ""
    puts "        ...                    ...                    ..."
    puts ""
  end

  def if_not_that_then_this(input)
    if input.match(/ta luego|exit|bye|ciao/)
      goodbye
    elsif input == "menu"
      menu
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
    programs_or_news
  end

  def goodbye
    puts ""
    puts "Hasta luego!"
    puts ""
    exit!
  end

end
