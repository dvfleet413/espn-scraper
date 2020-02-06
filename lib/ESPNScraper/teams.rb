class Teams

  def self.teams
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

  def self.team_abbreviations
    abbr_teams = []
    teams.each do |division, teams|
      teams.each {|team| team.each {|abbr, full| abbr_teams << abbr.to_s}}
    end
    abbr_teams
  end

end
