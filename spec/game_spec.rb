require 'spec_helper'

describe Game do

  describe '#random_play' do
    it 'should not change existing elements on the board' do
      game = Game.new(["X", "", "", "","","","","",""])
      expect{ game.random_play }.to_not change{game.board[0]}
    end

    it 'should add an O to the board' do
      game = Game.new(["X", "", "", "","","","","",""])
      game.random_play
      expect(game.board).to include("O")
    end

  end

end
