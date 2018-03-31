class BerkleeValencia::PROGRAM
  @@grad_programs
  @@other_programs

  def self.get_programs
    @@grad_programs = BerkleeValencia::SCRAPER.scrape_programs("grad")
    @@other_programs = BerkleeValencia::SCRAPER.scrape_programs("other")
  end

  def self.list_programs(type)
    type == "grad" ? programs = @@grad_programs : programs = @@other_programs
    programs == @@grad_programs ? i = 1 : i = (@@grad_programs.length + 1)
    programs.each.with_index(i) do |program, i|
      (program[:detail] != "") ? (puts "#{i}: #{program[:name].gsub("#{program[:detail]}", "")} (#{program[:detail]})") : (puts "#{i}: #{program[:name]}")
      program[:i] = i
    end# do
  end #list programs method

  def self.print_program(input)
    programs = @@grad_programs
    @@other_programs.each { |program| programs << program }
    program = programs.find { |program| program[:i] == input.to_i }
    url = program[:url]
    program_extended = BerkleeValencia::SCRAPER.scrape_program(url)
    BerkleeValencia::PRINTER.print_program(program, program_extended)
  end #method

end #class
