#!/usr/local/bin/ruby

require_relative 'views/welcome.rb'
require_relative 'views/goodbye.rb'
require_relative 'views/menu.rb'
require_relative 'views/game.rb'

if Welcome.new.screen
  Menu.new.screen
  Game.new.screen
else
  Goodbye.new.screen
end
