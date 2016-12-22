#!/usr/local/bin/ruby

# initialize with all the screens? ducktype them all 

require_relative 'views/welcome.rb'
require_relative 'views/goodbye.rb'
require_relative 'views/game.rb'

if Welcome.new.screen
  Game.new.screen
else
  Goodbye.new.screen
end
