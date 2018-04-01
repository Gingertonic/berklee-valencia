class BerkleeValencia::PROGRAM < BerkleeValencia::ITEM
  attr_accessor :type, :introduction, :subtitle, :highlights, :i

  @@graduate_programs = []
  @@other_programs = []

  def self.new_from_scraper(attribute_hash)
    new_program = BerkleeValencia::PROGRAM.new(attribute_hash[:title], attribute_hash[:url])
    new_program.type = attribute_hash[:type]
    new_program.subtitle = attribute_hash[:subtitle]
    new_program.i = @@all.length + 1
    @@all << new_program
    new_program.type == "Graduate Programs" ? @@graduate_programs << new_program : @@other_programs << new_program
  end

  def extended_info_from_scraper(attribute_hash)
    @highlights = attribute_hash[:highlights]
    @introduction = attribute_hash[:introduction]
  end

  def self.find_by_index(input)
    @@all.detect{|program| program.i == input}
  end

  def self.graduate_programs
    @@graduate_programs
  end

  def self.other_programs
    @@other_programs
  end

end
