# CLI Controller
class ESPNScraper::CLI
  attr_accessor :team, :url

  def run
    list_teams
    menu
    Scraper.scrape_new_articles(@url)
    display_articles
    binding.pry
  end

  def list_teams
    Teams.teams.each do |division, teams|
      puts division.to_s.sub(/_/, ' ').upcase
      teams.each do |team|
        team.each{|key,value| puts "  #{key.to_s.upcase} - #{value}"}
      end
    end
  end

  def menu
    puts "Type the abbreviated name of the team you'd like to read about..."
    @team = gets.chomp.downcase
    Teams.team_abbreviations.include?(@team) ? build_url : invalid_entry
  end

  def invalid_entry
    puts "Sorry, we didn't understand your entry..."
    puts "Please enter an the abbreviated name of your team (e.g. bos, bal, nyy)"
    menu
  end

  def display_articles
    Article.all.slice(0,5).each_with_index do |article, index|
      puts "#{index + 1}. #{article.title} \n \n"
      puts "  #{article.description} \n \n \n"
    end
  end

  private
    def build_url
      @url = "https://www.espn.com/mlb/team/_/name/" + "#{@team}"
    end
end
