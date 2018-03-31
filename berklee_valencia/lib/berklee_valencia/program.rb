class BV::PROGRAM
  @@grad_programs
  @@other_programs
  def self.list_programs
    @@grad_programs = BV::SCRAPER.scrape_graduate_programs
    @@other_programs = BV::SCRAPER.scrape_other_programs
    puts "--------------------------------------------------------------"
    puts "Enter the number of the program you'd like to read more about."
    puts "--------------------------------------------------------------"
    puts "Graduate Programs"
    @@grad_programs.each.with_index(1) do |gradprogram, i|
      if gradprogram[:detail] != ""
        puts "#{i}: #{gradprogram[:name].gsub("#{gradprogram[:detail]}", "")} (#{gradprogram[:detail]})"
      else
        puts "#{i}: #{gradprogram[:name]}"
      end
      gradprogram[:i] = i
    end

    puts ""
    puts "Other Programs"
    @@other_programs.each.with_index(@@grad_programs.length + 1) do |otherprogram, i|
      if otherprogram[:detail] != ""
        puts "#{i}: #{otherprogram[:name]} (#{otherprogram[:detail]})"
      else
        puts "#{i}: #{otherprogram[:name]}"
      end
      otherprogram[:i] = i
    end
  end

  def self.print_program(input)
    programs = @@grad_programs
    @@other_programs.each { |program| programs << program }
    program = programs.find { |program| program[:i] == input.to_i }
    url = program[:url]
    program_extended = BV::SCRAPER.scrape_program(url)
    BV::PRINTER.print_program(program, program_extended)
  end #method

end #class
