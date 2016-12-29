require_relative 'invoker.rb'
require_relative '../../views/game/one_player_game.rb'

class Client
  def initialize
    @invoker = Invoker.new
    @one_player_game = OnePlayerGame.new
  end

  def take_move
    
  end

  private

  attr_reader :one_player_game, :invoker
end