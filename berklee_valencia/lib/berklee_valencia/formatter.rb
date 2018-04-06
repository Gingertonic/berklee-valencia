class Formatter
  def self.wrap(text, width=80)
	  text.gsub(/(.{1,#{width}})(\s+|\Z)/, "\\1\n")
	end

  def self.urlwrap(text, width=80)
	  text.gsub(/(.{1,#{width}})/, "\\1\n")
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
      bordertestlength = [article.title.length, (article.author.length + article.date.length + 5)].max
      borderlength = [bordertestlength, 80].min
      borderlength.times {border << "-"}
      border
    end

    def self.gap_maker(article, border)
      gap = ""
      (border.length - article.author.length - article.date.length).times {gap << " "}
      gap
    end

    def self.body(article)
      article.body.each do |paragraph|
        if paragraph.match(/-{3} /)
          puts " ______________________________________________________________________________"
          puts "  ||               Press enter to scroll to the next section                ||"
          puts "  ||                or type 'end' to skip to end of article.                ||"
          puts " ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
          input = gets.strip
          if input == "end"
            return "end"
          end
          puts "#{wrap(paragraph)}"
          puts ""
        elsif !paragraph.match(/click here/i) && !paragraph.match(/•/)
          if paragraph.match(/below:/) || paragraph.match(/^Watch|^Listen/)
            media_compiler(article, paragraph)
          else
            puts "#{wrap(paragraph)}"
            puts ""
          end #nestedif
        end #if
      end #do
    end #print_body method

    def self.media_compiler(article, paragraph)
      if paragraph.match(/below:/)
        puts " - - - - - - - - - - - - - - - - - Media - - - - - - - - - - - - - - - - - - -"
        puts "#{wrap(paragraph)}"
        puts "#{urlwrap("        Visit #{(article.related_links.shift)}")}"
        puts "#{urlwrap("        Visit #{(article.related_links.shift)}")}"
        puts " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
      elsif paragraph.match(/^Watch|^Listen/i)
        puts " - - - - - - - - - - - - - - - - - Media - - - - - - - - - - - - - - - - - - -"
        puts "#{wrap(paragraph)}"
        puts "#{urlwrap("        Visit #{(article.related_links.shift)}")}"
        puts " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
      end
    end

    def self.end(article)
      puts ""
      puts " ______________________________________________________________________________"
      puts "  ||                          END OF ARTICLE                                ||"
      puts "  ||              Type 'open' to see full article in browser                ||"
      puts "  ||                    or hit enter to see all options                     ||"
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
