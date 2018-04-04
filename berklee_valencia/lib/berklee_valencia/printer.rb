class BerkleeValencia::PRINTER

  def self.print_programs_list
    puts "Graduate Programs"
    BerkleeValencia::PROGRAM.graduate_programs.each do |program|
      if program.subtitle.length > 0
        puts "#{program.i}: #{program.title.gsub(program.subtitle, "")} (#{program.subtitle})"
      else
        puts "#{program.i}: #{program.title}"
      end
    end
    puts ""
    puts "Other Programs"
    BerkleeValencia::PROGRAM.other_programs.each do |program|
      if program.subtitle.length > 0
        puts "#{program.i}: #{program.title.gsub(program.subtitle, "")} (#{program.subtitle})"
      else
        puts "#{program.i}: #{program.title}"
      end
    end
    puts ""
  end

  def self.print_program(program)
    Formatter::FORMATPROGRAM.header(program)
    Formatter::FORMATPROGRAM.intro(program)
    if program.highlights.length > 0
      Formatter::FORMATPROGRAM.highlights(program)
    end
    Formatter::FORMATPROGRAM.more_info(program)
  end

  def self.print_article_categories
    BerkleeValencia::CATEGORY.all.each {|cat| puts "#{cat.i}. #{cat.title}"}
    puts ""
  end

  def self.print_articles_list(category)
    category.articles.each do |article|
      puts "#{article.i}: #{Formatter.wrap(article.title)}"
      puts "  // Posted on #{article.date}"
      puts "#{Formatter.wrap(article.excerpt)}"
      puts ""
    end
  end

  def self.print_article(article)
    Formatter::FORMATARTICLE.header(article)
    Formatter::FORMATARTICLE.body(article)
    Formatter::FORMATARTICLE.end(article)
  end

end
