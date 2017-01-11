#!/usr/local/bin/ruby

require_relative '../views/welcome.rb'
require_relative '../views/goodbye.rb'
require_relative '../views/menu.rb'
require_relative '../views/player_selection.rb'
require_relative '../views/game/one_player_game.rb'
require_relative '../views/game/two_player_game.rb'
# require_relative '../views/screen.rb'

unless Welcome.new.screen
  Goodbye.new.screen
  exit
end

case Menu.new.screen
when true
  # PlayerSelection.new.screen
  OnePlayerGame.new(PlayerSelection.new.screen).screen
when false
  TwoPlayerGame.new.screen
end

# Game.new(Menu.new.screen).screen ?

# Welcome.new.screen
