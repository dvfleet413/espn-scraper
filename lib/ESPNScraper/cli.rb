# CLI Controller
class ESPNScraper::CLI
  attr_accessor :sport, :team, :url, :article

  def run
    welcome
  end

  def welcome
    puts "Welcome to the ESPN Scraper, your source for all the latest news for the MLB, NFL, NHL, and NBA!".colorize(:blue)
    puts "1. MLB"
    puts "2. NBA"
    puts "3. NFL"
    puts "4. NHL"
    puts "Type the number of the sport you'd like to read about...".colorize(:yellow)
    input = gets.chomp.downcase
    case input
    when "1"
      @sport = "mlb"
      list_teams
    when "2"
      @sport = "nba"
      list_teams
    when "3"
      @sport = "nfl"
      list_teams
    when "4"
      @sport = "nhl"
      list_teams
    when "exit"
      puts "Ending the program. See you again soon!".colorize(:yellow)
      exit
    else
      invalid_entry
      welcome
    end
  end

  def list_teams
    case self.sport
    when "mlb"
      all_teams = Teams.mlb_teams
    when "nba"
      all_teams = Teams.nba_teams
    when "nfl"
      all_teams = Teams.nfl_teams
    when "nhl"
      all_teams = Teams.nhl_teams
    end
    all_teams.each do |division, teams|
      puts division.to_s.sub(/_/, ' ').upcase.colorize(:magenta).bold
      teams.each do |team|
        team.each{|key,value| puts "  #{key.to_s.upcase} - #{value}"}
      end
    end
    menu
  end

  def menu
    puts "Type the abbreviated name of the team you'd like to read about.".colorize(:yellow)
    puts "  Other Options...".colorize(:yellow)
    puts "    1. Select New Sport".colorize(:yellow)
    puts "    2. Exit".colorize(:yellow)
    input = gets.chomp.downcase
    if Teams.team_abbreviations(self.sport).include?(input)
      @team = input
      build_url
      self.sport == "nhl" ? Scraper.scrape_new_nhl_articles(self.url) : Scraper.scrape_new_articles(self.url)
      display_articles
    elsif input == "1"
      Article.destroy_all
      run
    elsif input == "2" || input.downcase == "exit"
      puts "Ending the program. See you again soon!".colorize(:yellow)
      exit
    else
      invalid_entry
      menu
    end
  end

  def invalid_entry
    puts "Sorry, we didn't understand your entry...".colorize(:red)
    puts "Please try again...".colorize(:red)
  end

  def display_articles
    Article.all.slice(0,5).each_with_index do |article, index|
      puts "#{index + 1}. #{article.title}".colorize(:light_blue).bold
      puts "  #{article.description} \n \n"
    end
    article_menu
  end

  def article_menu
    puts "Enter the number of the article you would like to read.".colorize(:yellow)
    puts "  Other Options...".colorize(:yellow)
    puts "    6. Select New Sport".colorize(:yellow)
    puts "    7. Select New Team".colorize(:yellow)
    puts "    8. Exit".colorize(:yellow)
    input = gets.chomp
    if input.to_i.between?(1, 5)
      article_index = input.to_i - 1
      @article = Article.all[article_index]
      show_article_content
      exit_menu
    elsif input == "6"
      Article.destroy_all
      run
    elsif input == "7"
      Article.destroy_all
      list_teams
      menu
    elsif input == "8" || input.downcase == "exit"
      puts "Ending the program. See you again soon!".colorize(:yellow)
      exit
    else
      invalid_entry
      article_menu
    end
  end

  def show_article_content
    Scraper.get_content(self.article)
    puts "#{self.article.title} \n \n".colorize(:light_blue).bold
    if self.article.content.size > 0
      self.article.content.each {|p| puts "#{p.text} \n \n"}
    else
      puts "This is a link to an ESPN Radio report. To listen to the report vist: #{self.article.url}".colorize(:red)
    end
  end

  def exit_menu
    puts "Finished reading? Enter one of the following options...".colorize(:yellow)
    puts "1 - Go back to article list for your team"
    puts "2 - Select a new sport"
    puts "3 - Select a new team in this league"
    puts "4 - Exit the program"

    input = gets.chomp
    if input == "1"
      display_articles
      article_menu
    elsif input == "2"
      Article.destroy_all
      run
    elsif input == "3"
      list_teams
    elsif input == "4" || input.downcase == "exit"
      puts "Ending the program. See you again soon!".colorize(:yellow)
      exit
    else
      invalid_entry
      exit_menu
    end
  end

  private
    def build_url
      @url = "https://www.espn.com/" + "#{@sport}" + "/team/_/name/" + "#{@team}"
    end
end
