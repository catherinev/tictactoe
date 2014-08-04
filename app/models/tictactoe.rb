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
    # check if there is a way to win
    board.empty_cells.each do |cell_num|
      new_board = board.dup
      new_board[cell_num] = "O" 
      if Board.new(new_board).winner == "O"
        return board[cell_num] = "O"
      end
    end
    # block if the other player is about to win
    board.empty_cells.each do |cell_num|
      new_board = board.dup
      new_board[cell_num] = "X"
      if Board.new(new_board).winner == "X"
        return board[cell_num] = "O"
      end
    end

    # pick option that gives opponent least ways to win
  
  end

  def count_ways_to_win(player)
    count = 0
    case player
    when "X"
      all_lines.each do |line|
        unless line.include?("O")
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
    diags << [board[0] + board[4] + board[8]]
    diags << [board[2] + board[4] + board[6]]
  end

  def all_lines
    rows + cols + diags
  end

  def corners
    [0, 2, 6, 8]
  end

  
  

end