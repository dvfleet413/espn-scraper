require "rspec"
require "spec_helper"
require_relative "../config/environment.rb"

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
