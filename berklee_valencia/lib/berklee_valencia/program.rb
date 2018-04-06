class BerkleeValencia::PROGRAM < BerkleeValencia::ITEM
  attr_accessor :type, :introduction, :subtitle, :highlights, :i
  @@all = []
  @@graduate_programs = []
  @@other_programs = []

  def self.new_from_scraper(attribute_hash)
    BerkleeValencia::PROGRAM.new(attribute_hash[:title], attribute_hash[:url]).tap do |program|
      program.type = attribute_hash[:type]
      program.subtitle = attribute_hash[:subtitle]
      program.i = @@all.length + 1
      @@all << program
      program.type == "Graduate Programs" ? @@graduate_programs << program : @@other_programs << program
    end
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

  def self.all
    @@all
  end

end
