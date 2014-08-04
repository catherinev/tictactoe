class Board

  def initialize(array)
    @board = array
  end

  def random_play 
    empty_elements = []
    board.each_with_index do |element, index|
      if element == ""
        empty_elements << index
      end
    end

    if empty_elements
      new_play = empty_elements.sample
      board[new_play] = "O"
    end

  end

  
  attr_reader :board

end