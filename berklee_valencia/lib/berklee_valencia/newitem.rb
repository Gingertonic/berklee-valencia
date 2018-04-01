class BerkleeValencia::ITEM
  attr_reader :title, :url
  @@all = []

  def initialize(title, url)
    @title = title
    @url = url
  end

  def self.all
    @@all
  end
end
