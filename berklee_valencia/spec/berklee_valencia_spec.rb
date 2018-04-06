# require "spec-helper"

RSpec.describe BerkleeValencia do
  it "has a version number" do
    expect(BerkleeValencia::VERSION).not_to be nil
  end

  it "has an Article class" do
    expect(BerkleeValencia::ARTICLE).not_to be nil
  end


  it "has an Program class" do
    expect(BerkleeValencia::PROGRAM).not_to be nil
  end
end

RSpec.describe BerkleeValencia::ARTICLE do
    let(:article) { BerkleeValencia::ARTICLE.new("Test Article Title", "www.test.com")}
    let(:attribute_hash) { {title: "test article", url: "www.testing.com", category: "category x", date: "today", excerpt: "blah blah blah"} }
    let(:article_from_scraper) { BerkleeValencia::ARTICLE.new_from_scraper(attribute_hash)}
    let(:extended_hash) { {author: "Berk Lee", related_links: "related links", body: "body text" } }

    it "creates a new article" do
      expect(article).to be_instance_of BerkleeValencia::ARTICLE
    end

    it "creates a new article with a title and url" do
      expect(article).to have_attributes(title: "Test Article Title", url: "www.test.com")
    end

    it "can create a new article from a hash of attributes" do
      expect(article_from_scraper).to have_attributes(title: "test article", url: "www.testing.com", category: "category x", date: "today", excerpt: "blah blah blah")
    end

    it "can add extended info from a second hash of attributes" do
      article_from_scraper.extended_info_from_scraper(extended_hash)
      expect(article_from_scraper).to have_attributes(author: "Berk Lee", related_links: "related links", body: "body text" )
    end

end

RSpec.describe BerkleeValencia::PROGRAM do
  BerkleeValencia::PROGRAM.new("unsaved program", "www.unsavedprogram.com")
  let(:all) { BerkleeValencia::PROGRAM.all }
  let(:program1) { {title: "program 1", url: "www.program_1.com", type: " Graduate Programs ", subtitle: "yadda yadda yadda"} }
  let(:program2) { {title: "program 2", url: "www.program_2.com", type: " Other Programs ", subtitle: "yeah yeah yeah"} }
  let(:program) { BerkleeValencia::PROGRAM.new_from_scraper(program1) }
  let(:another_program) { BerkleeValencia::PROGRAM.new_from_scraper(program2) }

  it "has an @@all array and pushes new programs to it when made from the scraper" do
    program
    another_program
    expect(all).to be_instance_of Array
    expect(all.length).to eq(2)
  end

  it "can create a new program from a hash of attributes" do
    expect(program).to have_attributes(title: "program 1", url: "www.program_1.com", type: " Graduate Programs ", subtitle: "yadda yadda yadda")
  end
end
