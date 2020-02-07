class Teams



  def self.mlb_teams
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

  def self.nba_teams
    {atlantic: [{bos: "Boston Celtics"},
               {bkn: "Brooklyn Nets"},
               {nyk: "New York Knicks"},
               {phi: "Philadelphia 76ers"},
               {tor: "Toronto Raptors"}],
     central: [{chi: "Chicago Bulls"},
                  {cle: "Cleveland Cavaliers"},
                  {det: "Detroit Pistons"},
                  {ind: "Indiana Pacers"},
                  {mil: "Milwaukee Bucks"}],
     southeast: [{atl: "Atlanta Hawks"},
              {cha: "Charlotte Hornets"},
              {mia: "Miami Heat"},
              {orl: "Orlando Magic"},
              {wsh: "Washington Wizards"}],
     northwest: [{den: "Denver Nuggets"},
               {min: "Minnesota Timberwolves"},
               {okc: "Oklahoma City Thunder"},
               {por: "Portland Trail Blazers"},
               {utah: "Utah Jazz"}],
     pacific: [{gsw: "Golden State Warriors"},
                   {lac: "LA Clippers"},
                   {lal: "LA Lakers"},
                   {phx: "Phoenix Suns"},
                    {sac: "Sacramento Kings"}],
      Southwest: [{dal: "Dallas Mavericks"},
                {hou: "Houston Rockets"},
                {mem: "Memphis Grizzlies"},
                {nop: "New Orleans Pelicans"},
                {sas: "San Antonio Spurs"}]}
  end

  def self.nhl_teams
# todo - add hash of teams
  end

  def self.nfl_teams
# todo - add hash of teams
  end

  def self.team_abbreviations(sport)
    abbr_teams = []

    case sport
    when "mlb"
      teams = mlb_teams
    when "nba"
      teams = nba_teams
    end

    teams.each do |division, teams|
      teams.each {|team| team.each {|abbr, full| abbr_teams << abbr.to_s}}
    end
    abbr_teams
  end

end
