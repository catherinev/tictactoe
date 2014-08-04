class Game
  attr_reader :board

  def initialize(array)
    @board = array
  end

  def random_play 
    if empty_cells.length > 0
      new_play = empty_cells.sample
      board[new_play] = "O"
    end
  end

  def finished?
    find_winner != nil
  end

  def find_winner

  end

  def winner
    
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

end