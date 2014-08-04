require 'spec_helper'

describe Game do

  describe '#random_play' do
    it 'should not change existing elements on the board' do
      game = Game.new(["", "", "", "","X","","","",""])
      expect{ game.random_play }.to_not change{game.board[4]}
    end

    it 'should add an \'O\' to the board' do
      game = Game.new(["X", "", "", "","","","","",""])
      game.random_play
      expect(game.board).to include("O")
    end
  end

  describe '#finished' do
    it 'should return true if there are no empty cells' do
      game = Game.new(["X", "X", "X", "X", "X", "O", "O", "O", "O"])
      expect(game.finished?).to be true
    end

    it 'should return true if there are three Xs or Os in a row' do
      game = Game.new(["X", "X", "X", "", "", "", "", "O", "O"])
      expect(game.finished?).to be true
    end

    it 'should return true if there are three Xs or Os in a column' do
      game = Game.new(["X", "O", "X", "", "O", "X", "", "O", "O"])
      expect(game.finished?).to be true
    end

    it 'should return true if there are three Xs or Os on a diagonal' do
      game = Game.new(["X", "O", "X", "O", "X", "", "", "O", "X"])
      expect(game.finished?).to be true
    end

    it 'should return false if there are empty cells and no three Xs or Os in a row' do
      game = Game.new(["X", "", "", "", "", "", "", "O", "X"])
      expect(game.finished?).to be false
    end
  end



end
