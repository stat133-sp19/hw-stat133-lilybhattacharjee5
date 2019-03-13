## Data `firstname-lastname.csv`

Here's the description of the data variables:

- `team_name`: the name of the team that the player was on at the time of the shot e.g. "Golden State Warriors".
- `game_date`: the date that the shot was taken, expressed in MM/DD/YY format. If month < 10, the date is expressed in M/DD/YY format e.g. 3/24/17. If day < 10, the date is expressed in MM/D/YY format e.g. 11/3/16.
- `season`: the year in which the season corresponding to the shot in consideration began, expressed in YYYY form e.g. 2016.
- `period`: an NBA game is divided into 4 periods, each 12 mins long e.g. a value of period = 2 indicates the 2nd period of the game (12-24 min).
- `minutes_remaining`: the number of minutes remaining in the current period.
- `seconds_remaining`: the number of seconds remaining in the current period.
- `shot_made_flag`: whether a shot was successful (y) or unsuccessful (n).
- `action_type`: the basketball move used by the player to pass defenders, gain access to the basket, get a clean pass to a teammate to score a 2- or 3-pointer e.g. "Alley Oop Dunk Shot."
- `shot_type`: whether the shot is a 2- or 3-point field goal e.g. "2PT Field Goal."
- `shot_distance`: distance to the basket (in feet) e.g. 0.
- `opponent`: the name of the team that the player was playing against e.g. "Sacramento Kings."
- `x`: the horizontal coordinate of the court (in inches) where a shot occurred.
- `y`: the vertical coordinate of the court (in inches) where a shot occurred.
