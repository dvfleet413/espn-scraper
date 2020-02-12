require "rspec"
require "spec_helper"
require_relative "../config/environment.rb"

RSpec.describe Scraper do
  describe ".scrape_new_articles" do
    articles = Scraper.scrape_new_articles("https://www.espn.com/mlb/team/_/name/bos")
    it "returns an array" do
      expect(articles.class).to eq Array
    end
    it "contains instances of the Article class" do
      expect(articles[0].class).to eq Article
    end
    it "contains at least 5 elements" do
      expect(articles.size).to be >= 5
    end
  end

  describe ".scrape_new_nhl_articles" do
    articles = Scraper.scrape_new_nhl_articles("https://www.espn.com/nhl/team/_/name/bos")
    it "returns an array" do
      expect(articles.class).to eq Array
    end
    it "contains instances of the Article class" do
      expect(articles[0].class).to eq Article
    end
    it "contains at least 5 elements" do
      expect(articles.size).to be >= 5
    end
  end
end
