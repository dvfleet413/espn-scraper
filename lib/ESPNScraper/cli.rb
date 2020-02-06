# CLI Controller
class ESPNScraper::CLI
  attr_accessor :team, :url, :article

  def run
    list_teams
    menu
    Scraper.scrape_new_articles(@url)
    display_articles
    article_menu
    show_article_content
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
    if Teams.team_abbreviations.include?(@team)
      build_url
    else
      invalid_entry
      menu
    end
  end

  def invalid_entry
    puts "Sorry, we didn't understand your entry..."
    puts "Please try again..."
  end

  def display_articles
    Article.all.slice(0,5).each_with_index do |article, index|
      puts "#{index + 1}. #{article.title} \n \n"
      puts "  #{article.description} \n \n \n"
    end
  end

  def article_menu
    puts "Enter the number of the article you would like to read..."
    input = gets.chomp
    if input.to_i.between?(1, 5)
      article_index = input.to_i - 1
      @article = Article.all[article_index]
    else
      invalid_entry
      article_menu
    end
  end

  def show_article_content
    Scraper.get_content(self.article)
    # puts "#{self.article.content}"
    self.article.content.each {|p| puts "#{p.text} \n \n"}
  end

  private
    def build_url
      @url = "https://www.espn.com/mlb/team/_/name/" + "#{@team}"
    end
end
