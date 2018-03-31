class Formatter

  def self.wrap(text, width=80)
	  text.gsub(/(.{1,#{width}})(\s+|\Z)/, "\\1\n")
	end

  class Article < Formatter
    def self.header(article, article_extended)
      border = border_maker(article, article_extended)
      puts ""
      2.times {puts "#{border}"}
      puts "#{wrap(article[:title])}"
      gap = gap_maker(article, article_extended, border)
      puts "#{article_extended[:author]}#{gap}#{article[:date]}"
      2.times {puts "#{border}"}
    end

    def self.border_maker(article, article_extended)
      border = ""
      if article[:title].length < (article_extended[:author].length + article[:date].length)
        borderlength = article_extended[:author].length + article[:date].length + 5
        borderlength.times {border << "-"}
      elsif article[:title].length > 80
        80.times {border << "-"}
      else
        borderlength = article[:title].length
        borderlength.times {border << "-"}
      end
      border
    end

    def self.gap_maker(article, article_extended, border)
      gap = ""
      if border.length > article[:title].length
        5.times {gap << " "}
      else
        (article[:title].length - article_extended[:author].length - article[:date].length).times {gap << " "}
      end
      gap
    end

    def self.body(article, article_extended)
      article_extended[:body].each do |paragraph|
        if paragraph.match(/-{3} /)
          puts " ______________________________________________________________________________"
          puts "  ||               Press enter to scroll to the next section                ||"
          puts "  ||                   or type 'menu' to see all options                    ||"
          puts " ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
          input = gets.strip
          if input == "menu"
            return "abort mission!"
          end
        end

        if !paragraph.downcase.match(/click here/)
          if paragraph.match(/below/)
            puts "#{wrap(paragraph)}"
            puts "        Vist #{article_extended[:related_links].shift}"
          elsif paragraph ==  " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
              puts "        Vist #{article_extended[:related_links].shift}"
              puts paragraph
          else
            puts "#{wrap(paragraph)}"
            puts ""
          end #nestedif
        end #if
      end #do
    end #print_body method

    def self.end
      puts ""
      puts " ______________________________________________________________________________"
      puts "  ||                             END OF ARTICLE                             ||"
      puts " ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
      2.times {puts ""}
    end
  end

  class Program < Formatter
    def self.header(program)
      border = ""
      (program[:name].gsub("#{program[:detail]}", "").length + 4).times {border << "-"}
      puts ""
      2.times {puts border}
      puts "  #{program[:name].gsub("#{program[:detail]}", "")}"
      if program[:detail] != ""
        puts "  (#{program[:detail]})"
      end
    end

    def self.intro(program_extended)
      puts "--------------------------------------------------------------------------------"
      puts "                                Introduction"
      puts "--------------------------------------------------------------------------------"
      puts "#{wrap(program_extended[:introduction])}"
      puts ""
    end

    def self.highlights(program_extended)
      puts "--------------------------------------------------------------------------------"
      puts "                               Program Highlights"
      puts "--------------------------------------------------------------------------------"
      program_extended[:highlights].each do |highlight|
        puts "| #{highlight[:hl_title]} |"
        puts "#{wrap(highlight[:hl_body])}"
        puts ""
      end
    end

    def self.more_info(program)
      puts "--------------------------------------------------------------------------------"
      puts "                        For full program information:"
      puts "--------------------------------------------------------------------------------"
      puts "Visit #{program[:url]}"
      2.times {puts "--------------------------------------------------------------------------------"}
      2.times {puts ""}
    end

  end #Program class

end #Formatter
