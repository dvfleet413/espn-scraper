# CLI Controller
class ESPNScraper::CLI
  attr_accessor :team, :url, :article

  def run
    list_teams
    menu
    Scraper.scrape_new_articles(@url)
    display_articles
    article_menu
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
    puts "Type the abbreviated name of the team you'd like to read about, or type exit to leave the program."
    input = gets.chomp.downcase
    if Teams.team_abbreviations.include?(input)
      @team = input
      build_url
    elsif input == "exit"
      exit 
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
    puts "Enter the number of the article you would like to read, or type exit to leave the program."
    input = gets.chomp
    if input.to_i.between?(1, 5)
      article_index = input.to_i - 1
      @article = Article.all[article_index]
      show_article_content
      exit_menu
    elsif input.downcase == "exit"
      exit
    else
      invalid_entry
      article_menu
    end
  end

  def show_article_content
    Scraper.get_content(self.article)
    puts "#{self.article.title} \n \n"
    if self.article.content.size > 0
      self.article.content.each {|p| puts "#{p.text} \n \n"}
    else
      puts "This is a link to an ESPN Radio report. To listen to the report vist: #{self.article.url}"
    end
  end

  def exit_menu
    puts "Finished reading? Enter one of the following options..."
    puts "1 - Go back to article list for your team."
    puts "2 - Select a new team."
    puts "3 - Exit the program."

    input = gets.chomp
    if input == "1"
      display_articles
      article_menu
    elsif input == "2"
      Article.destroy_all
      run
    elsif input == "3"
      exit
    else
      invalid_entry
      exit_menu
    end
  end

  private
    def build_url
      @url = "https://www.espn.com/mlb/team/_/name/" + "#{@team}"
    end
end
