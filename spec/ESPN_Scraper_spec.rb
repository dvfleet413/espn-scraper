require "rspec"
require "spec_helper"
require_relative "../config/environment.rb"

RSpec.describe ESPNScraper do
  it "has a version number" do
    expect(ESPNScraper::VERSION).not_to be nil
  end
end

RSpec.describe Article do
  article = Article.new("title", "description", "url")
  describe "#initialize" do
    it "initiializes with a title, description and url" do
      expect(article.title).to eq "title"
      expect(article.description).to eq "description"
      expect(article.url).to eq "url"
    end
  end

  describe ".destroy_all" do
    it "removes all objects from the @@all class variable" do
      Article.destroy_all
      expect(Article.all.size).to eq 0
    end
  end

  describe ".all" do
    it "objects are added to @@all when instantiated" do
      Article.destroy_all
      article = Article.new("title", "description", "url")
      expect(Article.all.size).to eq 1
      article_two = Article.new("title", "desc", "url")
      expect(Article.all.size).to eq 2
    end
  end
end

RSpec.describe ESPNScraper::CLI do

end

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

RSpec.describe Teams do
  describe ".mlb_teams" do
    it "returns a hash of teams" do
      teams = Teams.mlb_teams
      expect(teams.class).to eq Hash
      expect(teams.keys).to include(:al_east, :al_central, :al_west, :nl_east, :nl_central, :nl_west)
    end
  end

  describe ".nba_teams" do
    it "returns a hash of teams" do
      teams = Teams.nba_teams
      expect(teams.class).to eq Hash
      expect(teams.keys).to include(:atlantic, :central, :southeast, :northwest, :pacific, :southwest)
    end
  end

  describe ".nhl_teams" do
    it "returns a hash of teams" do
      teams = Teams.nhl_teams
      expect(teams.class).to eq Hash
      expect(teams.keys).to include(:atlantic, :central, :metropolitan, :pacific)
    end
  end

  describe ".nfl_teams" do
    it "returns a hash of teams" do
      teams = Teams.nfl_teams
      expect(teams.class).to eq Hash
      expect(teams.keys).to include(:afc_east, :afc_north, :afc_south, :afc_west, :nfc_east, :nfc_north, :nfc_south, :nfc_west)
    end
  end

  describe ".team_abbreviations" do
    it "returns an array of abbreviated names" do
      teams = Teams.team_abbreviations("mlb")
      expect(teams.class).to eq Array
      expect(teams.size).to be > 0
      expect(teams).to include("bos")
    end
  end
end
