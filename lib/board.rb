class Board
  STARTING_POSITIONS = [*0..8]
  WINNING_LINES = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [2,4,6],
    [0,4,8],
    [1,4,7],
    [2,5,8]
  ]

  def available_positions(taken_positions)
    STARTING_POSITIONS - [taken_positions]
  end

  # def next_possible_move(board)
  #   [
  #     ["X",1,2,3,4,5,6,7,8],
  #     [0,"X",2,3,4,5,6,7,8],
  #     [0,1,"X",3,4,5,6,7,8],
  #     [0,1,2,"X",4,5,6,7,8],
  #     [0,1,2,3,"X",5,6,7,8],
  #     [0,1,2,3,4,"X",6,7,8],
  #     [0,1,2,3,4,5,"X",7,8],
  #     [0,1,2,3,4,5,6,"X",8],
  #     [0,1,2,3,4,5,6,7,"X"]
  #   ]
  # end

  def winning_board?(board)
    WINNING_LINES.each do |line|
      return true if board.values_at(*line) == ["X","X","X"] ||
                     board.values_at(*line) == ["O","O","O"]
    end
    false
  end
end

# Too many variations.
#  Calculate on the fly?
#  Or persist the mapped moves?
# def can_win?(board)
#   board.values_at(0,1)
#   board.values_at(0,2)
#   board.values_at(1,2)
# end

# Move.new.(state).generate
# 1. Asses state of the board.
# 2. Look up a move based on that.
#  Feels like we're asking what it is,
#  then doing something
#  instead we should tell

class Move
  def initialize(state)
    @state = state
  end

  def given(board)
    available_moves.fetch(board)
  end

  def available_moves(board)
    one_level[board]
    {
      [0,1,2,3,4,5,6,7,8] => ["X",1,2,3,4,5,6,7,8]
    }
  end

  private

  attr_reader :state
end


def x_optimal_first_move
  {
    [0,1,2,3,4,5,6,7,8] => ["X",1,2,3,4,5,6,7,8]
  }
end


o_optimal_first_move[["X",1,2,3,4,5,6,7,8],[["X",1,2,3,"O",5,6,7,8]]]


hisrtory [["X",1,2,3,4,5,6,7,8],[["X",1,2,3,"O",5,6,7,8]]]

game_tree[history[0]][histpry[1]][histpry[2]]

def o_optimal_first_move
  {
    ["X",1,2,3,4,5,6,7,8] => ["X",1,2,3,"O",5,6,7,8],
    [0,"X",2,3,4,5,6,7,8] => ["X",1,2,3,"O",5,6,7,8],
    [0,1,"X",3,4,5,6,7,8] => ["X",1,2,3,"O",5,6,7,8],
    [0,1,2,"X",4,5,6,7,8] => ["X",1,2,3,"O",5,6,7,8],
    [0,1,2,3,"X",5,6,7,8] => ["0",1,2,3,"X",5,6,7,8],
    [0,1,2,3,4,"X",6,7,8] => [0,1,2,3,"O","X",6,7,8],
    [0,1,2,3,4,5,"X",7,8] => [0,1,2,3,"O",5,"X",7,8],
    [0,1,2,3,4,5,6,"X",8] => [0,1,2,3,"O",5,6,"X",8],
    [0,1,2,3,4,5,6,7,"X"] => [0,1,2,3,"O",5,6,7,"X"],
  }
end

def x_optimal_second_move
  {
    ["X",1,2,3,"O",5,6,7,8] => 
    ["X",1,2,3,"O",5,6,7,8] => 
    ["X",1,2,3,"O",5,6,7,8] => 
    ["X",1,2,3,"O",5,6,7,8] => 
    ["0",1,2,3,"X",5,6,7,8] => 
    [0,1,2,3,"O","X",6,7,8] => 
    [0,1,2,3,"O",5,"X",7,8] => 
    [0,1,2,3,"O",5,6,"X",8] => 
    [0,1,2,3,"O",5,6,7,"X"] => 
  }
end

def recur(board, hash, iterator)
  return hash if iterator == board.length
  hash.merge(
    board => board[iterator] = "X"
  )

end

# The optimal second has keys for all possible combinations of boards for an X and an O on the board
# compute that..






optimal_move[[0,1,2,3,4,5,6,7,8]] #=> ["X",1,2,3,4,5,6,7,8]
# For X
#  need to know the state of the board now, AND
optimal_move[[[0,1,2,3,4,5,6,7,8],["X",1,2,3,4,5,6,7,8]]] #=> 

# seperate X optimal move and O optimal move
# X optimal, can just take in a current board state, and map to an optimal move

# O can do the same

# general rule is key is the board state.
  # the key for each board state contains the nested possibilities,
  # each possibility's value is the desired move.
# When we change state we append it into the moves_history array []
# We traverse the hash of possible moves by using each item in the array as a key
# example:

# move_history = [
#   [0,1,2,3,4,5,6,7,8],
#   ["X",1,2,3,4,5,6,7,8]
# ]

first_wave[move[0]][move[1]] #=> ["X",1,2,3,"O",5,6,7,8] <- this is O's optimal move
# then we take the move:
def take_move
  board = first_wave[move[0]][move[1]]
  # redraw board / update the view
  move_history << first_wave[move[0]][move[1]]
end


def generate_move_tree(board)
  game_tree = {}
  game_tree[board] = {
    board[0]="X"
  }
end

def first_wave
  board = [0,1,2,3,4,5,6,7,8]
  [0,1,2,3,4,5,6,7,8] => {
    board.each{|space|
      space
    }
  }
end


  # {
  #   board {
  #     available_moves[0] => { optimal_response {
  #       available_move => { optimal_response:
  #         available_move => {}
  #       }
  #       available_move => { optimal_response:
  #         available_move => {}
  #       }
  #       available_move => { optimal_response:
  #         available_move => {}
  #       }
  #       available_move => { optimal_response:
  #         available_move => {}
  #       }
  #       available_move => { optimal_response:
  #         available_move => {}
  #       }
  #       available_move => { optimal_response:
  #         available_move => {}
  #       }
  #       available_move => { optimal_response:
  #         available_move => {}
  #       }
  #       available_move => { optimal_response:
  #         available_move => {}
  #       }
  #     }
  #     available_moves[1] => { optimal_response:
  #       available_move => {}
  #     }
  #     available_moves[2] => { optimal_response:
  #       available_move => {}
  #     }
  #     available_moves[3] => { optimal_response:
  #       available_move => {}
  #     }
  #     available_moves[4] => { optimal_response:
  #       available_move => {}
  #     }
  #     available_moves[5] => { optimal_response:
  #       available_move => {}
  #     }
  #     available_moves[6] => { optimal_response:
  #       available_move => {}
  #     }
  #     available_moves[7] => { optimal_response:
  #       available_move => {}
  #     }
  #     available_moves[8] => { optimal_response:
  #       available_move => {}
  #     }
  #   }
  # }
end



class AI < Player
  def move
    # consider board state       
    # take next move based on it
    # these arent two seprate things.
    # Asses boardstate
  end
end

class Person < Player
  def move
    # get input from user
    # disallow illegal move (maybe in the  view?)
    # update board state with move
  end
end


class Node
  def to_s
  end

  def add_edge
  end

end

class Tree

  def add_node
  end
end



