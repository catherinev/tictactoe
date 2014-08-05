class Game
  attr_reader :board, :winner

  def initialize(array)
    @board = array
    @winner = find_winner
    # 'O' is the computer
  end

# qualities of current state of the board ****************************
  def finished?
    if empty_cells.length == 0
      return true
    else
      return winner != nil
    end   
  end

  def find_winner
    all_lines.each do |line|
      if line.join == "XXX"
        return "X"
      elsif line.join == "OOO"
        return "O"
      end
    end
    nil
  end

  def forks?(player = "O")
    num_pairs = 0
    all_lines.each do |line|
      if line.join == player + player
        num_pairs += 1
      end
    end
    num_pairs > 1
  end

  def random_play(player = "O")
    unless finished?
      new_play = empty_cells.sample
      board[new_play] = player
    end
  end  

  def smart_play
    unless finished?
      if winning_cell
        return board[winning_cell] = "O"
      elsif cell_to_block
        return board[cell_to_block] = "O"
      elsif look_for_fork
        return board[look_for_fork] = "O"
      elsif block_fork
        return board[block_fork] = "O"
      elsif center_available?
        return board[4] = "O"
      elsif opposite_corner_play
        return board[opposite_corner_play] = "O"
      elsif corner_play
        return board[corner_play] = "O"
      else
        return random_play
      end
    end
  end

  # helper methods that need to be public**********
  
  def winning_cell # does this need to be public? => yes, see #block_fork
    empty_cells.each do |cell_num|
      new_board = board.dup
      new_board[cell_num] = "O" 
      if Game.new(new_board).winner == "O"
        return cell_num
      end
    end
    nil
  end

# ************************************************
  private

  def empty_cells
    empty_cells = []
    board.each_with_index do |cell, index|
      if cell == ""
        empty_cells << index
      end
    end
    empty_cells
  end

  def rows
    board.each_slice(3).to_a
  end

  def cols
    rows.transpose
  end

  def diags
    diags = []
    diags << [board[0], board[4], board[8]]
    diags << [board[2], board[4], board[6]]
  end

  def all_lines
    rows + cols + diags
  end
# *******************************************

  

  def opposite_corner_play
    corner_options = []
    corner_options << ["X", "", "", "", "", "", "", "", ""]
    corner_options << ["", "", "X", "", "", "", "", "", ""]
    corner_options << ["", "", "", "", "", "", "X", "", ""]
    corner_options << ["", "", "", "", "", "", "", "", "X"]
    unless corner_options.include?(board)
      return nil
    end
    return (8 - board.index("X"))
  end

  def corner_play
    if empty_cells.include?(4)
      return 4
    end
    available_corners = empty_cells & [0, 2, 6, 8]
    if available_corners
      return available_corners[0]
    end
  end

  def cell_to_block
    empty_cells.each do |cell_num|
      new_board = board.dup
      new_board[cell_num] = "X"
      if Game.new(new_board).winner == "X"
        return cell_num
      end
    end
    nil
  end

  def block_fork
    empty_cells.each do |cell_num|
      test_board = board.dup
      test_board[cell_num] = "X"
      test_game = Game.new(test_board)
      if test_game.forks?("X")
        # is there a way to force a different play?
        remaining_cells = empty_cells.select{|num| num != cell_num}
        remaining_cells.each do |cell_num2|
          second_test_board = board.dup
          second_test_board[cell_num2] = "O"
          second_test_game = Game.new(second_test_board)
          if second_test_game.winning_cell && second_test_game.winning_cell != cell_num
            return cell_num2
          end
        end
      end
    end
    false
  end

  def center_available?
    empty_cells.include?(4)
  end

  def look_for_fork(player = "O")
    opponent = player == "O" ? "X" : "O"
    empty_cells.each do |cell_num|
      test_board = board.dup
      test_board[cell_num] = player
      test_game = Game.new(test_board)

      if test_game.forks?(player)
        return cell_num
      end
    end
    false
  end

end