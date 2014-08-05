class Game
  attr_reader :board, :winner

  def initialize(array)
    @board = array
    @winner = find_winner
  end


  def random_play 
    unless winner
      new_play = empty_cells.sample
      board[new_play] = "O"
    end
  end

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

  def smart_play
    unless winner
      if winning_cell
        return board[winning_cell] = "O"
      elsif cell_to_block
        return board[cell_to_block] = "O"
      elsif look_for_fork
        return board[look_for_fork] = "O"
      elsif block_fork
        return board[block_fork] = "O"
      elsif corner
        return board[corner] = "O"
      else
        return board[least_options_to_opponent] = "O"
      end
    end
  end

  def almost_win
    empty_cells.each do |cell_num|
      test_board = board.dup
      test_board[cell_num] = "O"
      test_game = Game.new(test_board)
      if test_game.winner == "O"
        return cell_num
      end
    end
    false
  end

  def num_ways_to_win(player)
    count = 0
    p all_lines
    case player
    when "X"
      all_lines.each do |line|
        unless line.include?("O")
          p line
          count += 1
        end
      end
    when "O"
      all_lines.each do |line|
        unless line.include?("X")
          count += 1
        end
      end
    end
    count
  end

  def look_for_fork(player = "O")
    puts "fork" + player
    opponent = player == "O" ? "X" : "O"
    puts opponent
    empty_cells.each do |cell_num|
      test_board = board.dup
      test_board[cell_num] = player
      test_game = Game.new(test_board)
      num_almost_wins = 0
      all_lines.each do |line|
        if line.join == opponent + opponent
          num_almost_wins += 1
        end
      end
      if num_almost_wins > 1
        return cell_num
      end
    end
    false
  end

  def all_lines
    rows + cols + diags
  end

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

  

  def winning_cell
    empty_cells.each do |cell_num|
      new_board = board.dup
      new_board[cell_num] = "O" 
      if Game.new(new_board).winner == "O"
        return cell_num
      end
    end
    nil
  end

  def corner
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

  def least_options_to_opponent
    # we want cell rank to be as low as possible -- it measures how many options the opponent will have if that space is played (sort of)
    cell_ranks = {}

    empty_cells.each do |cell_num|
      test_board = board.dup
      test_board[cell_num] = "O"

      test_game = Game.new(test_board)
      cell_ranks[cell_num] = test_game.num_ways_to_win("X")
    end

    min = cell_ranks.values.min
    top_options = cell_ranks.select{|cell_num, frequency| frequency == min}# any options with the minimum

    top_options.each do |cell|
      cell_num = cell[0]
      if rows[cell_num / 3].include?("X")
        cell_ranks[cell_num] -= 1
      end

      if cols[cell_num % 3].include?("X")
        cell_ranks[cell_num] -= 1
      end

      if [0,4,8].include?(cell_num)
        if diags[0].include?("X")
          cell_ranks[cell_num] -= 1
        end
      end

      if [2,4,6].include?(cell_num)
        if diags[1].include?("X")
          cell_ranks[cell_num] -= 1
        end
      end
    end

    min = cell_ranks.values.min
    top_options = cell_ranks.select{|cell_num, frequency| frequency == min}# any options with the minimum
    p top_options.keys

    best_cell = top_options.keys.sample
  end

  

  def block_fork
    empty_cells.each do |cell_num|
      test_board = board.dup
      test_board[cell_num] = "O"
      test_game = Game.new(test_board)
      if test_game.almost_win
        unless test_game.look_for_fork("X")
          return test_game.almost_win
        end
      end
    end
    false
  end

  

end