# CLI Controller
class ESPNScraper::CLI
  attr_accessor :team, :url

  def teams
    {al_east: [{bal: "Baltimore Orioles"},
               {bos: "Boston Red Sox"},
               {nyy: "New York Yankees"},
               {tb: "Tampa Bay Rays"},
               {tor: "Toronto Blue Jays"}],
     al_central: [{chw: "Chicago White Sox"},
                  {cle: "Cleveland Indians"},
                  {det: "Detroit Tigers"},
                  {kan: "Kansas City Royals"},
                  {min: "Minnesota Twins"}],
     al_west: [{hou: "Houston Astros"},
              {laa: "Los Angeles Angels"},
              {oak: "Oakland Athletics"},
              {sea: "Seattle Mariners"},
              {tex: "Texas Rangers"}],
     nl_east: [{atl: "Atlanta Braves"},
               {mia: "Miami Marlins"},
               {nym: "New York Mets"},
               {phi: "Philadelphia Phillies"},
               {was: "Washington Nationals"}],
      nl_central: [{chc: "Chicago Cubs"},
                   {cin: "Cincinnati Reds"},
                   {mil: "Milwaukee Brewers"},
                   {pit: "Pitsburgh Pirates"},
                    {stl: "St Louis Cardinals"}],
      nl_west: [{ari: "Arizona Diamondbacks"},
                {col: "Colorado Rockies"},
                {lad: "Los Angeles Dodgers"},
                {sd: "San Diego Padres"},
                {sf: "San Fransisco Giants"}]}
  end

  def team_abbreviations
    abbr_teams = []
    teams.each do |division, teams|
      teams.each {|team| team.each {|abbr, full| abbr_teams << abbr.to_s}}
    end
    abbr_teams
  end


  def call
    list_teams
    menu
    Scraper.scrape_new_articles(@url)
    display_articles
    binding.pry
  end

  def list_teams
    teams.each do |division, teams|
      puts division.to_s.sub(/_/, ' ').upcase
      teams.each do |team|
        team.each{|key,value| puts "  #{key.to_s.upcase} - #{value}"}
      end
    end
  end

  def menu
    puts "Type the abbreviated name of the team you'd like to read about..."
    @team = gets.chomp.downcase
    team_abbreviations.include?(@team) ? build_url : invalid_entry
  end

  def invalid_entry
    puts "Sorry, we didn't understand your entry..."
    puts "Please enter an the abbreviated name of your team (e.g. bos, bal, nyy)"
    menu
  end

#  def scrape
#    html = open(@url)
#    doc = Nokogiri::HTML(html)
#    stories = doc.css("div.item-info-wrap")
#    # title stories.css("h1").text
#    # description stories.css("p").text
#    stories.each do |story|
#      title = story.css("h1").text
#      description = story.css("p").text
#      Article.new(title, description)
#    end
#  end

  def display_articles
    Article.all.slice(0,5).each do |article|
      puts "#{article.title} \n \n"
      puts "  #{article.description} \n \n \n"
    end
  end

  private
    def build_url
      @url = "https://www.espn.com/mlb/team/_/name/" + "#{@team}"
    end
end
