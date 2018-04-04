class Formatter

  def self.wrap(text, width=80)
	  text.gsub(/(.{1,#{width}})(\s+|\Z)/, "\\1\n")
	end

  class Formatter::FORMATARTICLE < Formatter
    def self.header(article)
      border = border_maker(article)
      puts ""
      2.times {puts "#{border}"}
      puts "#{wrap(article.title)}"
      gap = gap_maker(article, border)
      puts "#{article.author}#{gap}#{article.date}"
      2.times {puts "#{border}"}
    end

    def self.border_maker(article)
      border = ""
      if article.title.length < (article.author.length + article.date.length)
        borderlength = article.author.length + article.date.length + 5
        borderlength.times {border << "-"}
      elsif article.title.length > 80
        80.times {border << "-"}
      else
        borderlength = article.title.length
        borderlength.times {border << "-"}
      end
      border
    end

    def self.gap_maker(article, border)
      gap = ""
      if border.length > article.title.length
        5.times {gap << " "}
      else
        (article.title.length - article.author.length - article.date.length).times {gap << " "}
      end
      gap
    end

    def self.body(article)
      article.body.each do |paragraph|
        if paragraph.match(/-{3} /)
          puts " ______________________________________________________________________________"
          puts "  ||               Press enter to scroll to the next section                ||"
          puts "  ||                   or type 'menu' to see all options                    ||"
          puts " ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
          input = gets.strip
          if input == "menu"
            return "menu"
          end
        elsif !paragraph.downcase.match(/click here/)
          if paragraph.match(/below/)
            puts "#{wrap(paragraph)}"
            puts "        Vist #{article.related_links.shift}"
          elsif paragraph ==  " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
              puts "        Vist #{article.related_links.shift}"
              puts paragraph
          else
            puts "#{wrap(paragraph)}"
            puts ""
          end #nestedif
        end #if
      end #do
    end #print_body method

    def self.end(article)
      puts ""
      puts " ______________________________________________________________________________"
      puts "  ||                          END OF ARTICLE                                ||"
      puts "  ||              Type 'open' to see full article in browser                ||"
      puts "  ||                    or hit enter to see more options.                   ||"
      puts " ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
      2.times {puts ""}
      input = gets.strip
      if input == "open"
        system("open #{article.url}")
      end
    end
  end #class

  class Formatter::FORMATPROGRAM < Formatter
    def self.header(program)
      border = ""
      (program.title.length + 4).times {border << "-"}
      puts ""
      2.times {puts border}
      puts "  #{program.title}"
      puts "  #{program.type}"
    end

    def self.intro(program)
      puts "--------------------------------------------------------------------------------"
      puts "                                Introduction"
      puts "--------------------------------------------------------------------------------"
      puts "#{wrap(program.introduction)}"
      puts ""
    end

    def self.highlights(program)
      puts "--------------------------------------------------------------------------------"
      puts "                               Program Highlights"
      puts "--------------------------------------------------------------------------------"
      program.highlights.each do |highlight|
        puts "| #{highlight[:hl_title]} |"
        puts "#{wrap(highlight[:hl_body])}"
        puts ""
      end
    end

    def self.more_info(program)
      puts "--------------------------------------------------------------------------------"
      puts "                        For full program information:"
      puts "--------------------------------------------------------------------------------"
      puts "Type 'open' to visit program homepage or hit enter to see more options."
      2.times {puts "--------------------------------------------------------------------------------"}
      2.times {puts ""}
      input = gets.strip
      if input == "open"
        system("open #{program.url}")
      end
    end

  end #Program class

end #Formatter
