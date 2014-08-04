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
    #check rows and columns
    0.upto(2) do |num|
      if row(num).join == "XXX" || col(num).join == "XXX"
        return "X"
      elsif row(num).join == "OOO" || col(num).join == "OOO"
        return "O"
      end
    end

    #check diagonals
    if diag(-1) == "XXX" || diag(1) == "XXX"
      return "X"
    elsif diag(-1) == "OOO" || diag(1) == "OOO"
      return "O"
    end
    nil
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

  def row(num)
    row = []
    board.each_with_index do |cell, index|
      if (index / 3) == num
        row << cell
      end
    end
    row
  end

  def col(num)
    col = []
    board.each_with_index do |cell, index|
      if (index % 3) == num
        col << cell
      end
    end
    col
  end

  def diag(num)
    #num can be 1 for positive or -1 for negative
    case num
    when -1
      return board[0] + board[4] + board[8]
    when 1
      return board[2] + board[4] + board[6]
    end
  end

end