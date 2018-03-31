class BerkleeValencia::PRINTER
  def self.print_article(article, article_extended)
    Formatter::Article.header(article, article_extended)
    Formatter::Article.body(article, article_extended)
    Formatter::Article.end
  end

  def self.print_program(program, program_extended)
    Formatter::Program.header(program)
    Formatter::Program.intro(program_extended)
    if program_extended[:highlights].length > 0
      Formatter::Program.highlights(program_extended)
    end
    Formatter::Program.more_info(program)
  end
end #class
