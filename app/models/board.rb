class Board < ActiveRecord::Base

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
    end

  end

  private
  attr_reader :board
  # Remember to create a migration!
end
