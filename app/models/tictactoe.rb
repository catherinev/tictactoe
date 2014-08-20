class Game
  attr_reader :board, :winner

  def initialize(array)
    @board = array
    @winner = find_winner
    # 'O' is the computer
  end

# qualities of current state of the board ****************************
  def finished?
    return true if empty_cells.length == 0
    find_winner != nil 
  end

  def find_winner
    all_lines.each do |line|
      return "X" if line.join == "XXX"
      return "O" if line.join == "OOO"     
    end
    nil
  end

  def forks?(player = "O")
    forks = []
    cells = []
    board.each_with_index do |cell, index|
      if cell == player
        cells << index
      end
    end

    cells.each do |cell|
      count = 0
      count +=1 if rows[(cell / 3)].join == player + player
      count +=1 if cols[(cell % 3)].join == player + player
      if [0,4,8].include?(cell)
        count +=1 if diags[0].join == player + player
      end

      if [2,4,6].include?(cell)
        count +=1 if diags[1].join == player + player
      end    
      if count > 1
        forks << cells
      end    
    end
    forks
  end

  def random_play(player = "O")
    unless finished?
      new_play = empty_cells.sample
      board[new_play] = player
    end
  end  

  def smart_play(player = "O")
    unless finished?
      if winning_cell
        puts "win"
        return board[winning_cell] = player
      elsif cell_to_block
        puts "block"
        return board[cell_to_block] = player
      elsif look_for_fork
        puts "look"
        return board[look_for_fork] = player
      elsif block_fork
        puts "block fork"
        return board[block_fork] = player
      elsif center_available?
        puts "center"
        return board[4] = player
      elsif opposite_corner_play
        puts "opp corner"
        return board[opposite_corner_play] = player
      elsif corner_play
        puts "corner"
        return board[corner_play] = player
      else
        puts "random"
        return random_play(player)
      end
    end
  end

  # helper methods that need to be public**********
  
  def winning_cell(player = "O") # does this need to be public? => yes, see #block_fork
    empty_cells.each do |cell_num|
      new_board = board.dup
      new_board[cell_num] = player
      if Game.new(new_board).winner == player
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

  def opposite_corner_play(player = "O")
    opponent = player == "O" ? "X" : "O"
    available_corners = empty_cells & [0, 2, 6, 8]
    available_corners.each do |cell_num|
      if board[8 - cell_num] == opponent
        return cell_num
      end
    end
    nil
  end

  def corner_play
    available_corners = empty_cells & [0, 2, 6, 8]
    if available_corners
      return available_corners.sample
    end
  end

  def cell_to_block(player = "O")
    opponent = player == "O" ? "X" : "O"
    empty_cells.each do |cell_num|
      new_board = board.dup
      new_board[cell_num] = opponent
      if Game.new(new_board).winner == opponent
        return cell_num
      end
    end
    nil
  end

  def block_fork(player = "O")
    opponent = player == "O" ? "X" : "O"
    empty_cells.each do |cell_num|
      test_board = board.dup
      test_board[cell_num] = opponent
      test_game = Game.new(test_board)
      unless test_game.forks?(opponent).empty?
        puts 'blah'
        empty_cells.each do |cell_num2|
          remaining_cells = empty_cells.select{|cell| cell != cell_num2}

          second_test_board = board.dup
          second_test_board[cell_num2] = player
          second_test_game = Game.new(second_test_board)

          possible = true

          remaining_cells.each do |cell|
            third_test_board = second_test_board.dup
            third_test_board[cell] = opponent
            third_test_game = Game.new(third_test_board)
            unless third_test_game.forks?(opponent).empty?
              possible = false unless third_test_game.winning_cell(player)
            end
          end

          if possible
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

      unless test_game.forks?(player).empty?
        return cell_num
      end
    end
    false
  end
end