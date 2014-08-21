require_relative '../app/models/tictactoe'

describe TicTacToeBoard do

  describe '#new_play' do
    it "puts a new move on the board" do
      new_board = TicTacToeBoard.new(["X","O", "X", "", "", "", "", "", ""])
      new_board.new_play({cell_num: 4, marker: "O"})
      expect(new_board.board).to eq ["X","O", "X", "", "O", "", "", "", ""]
    end
  end

  describe '#all_lines' do
    it "returns an array of all the lines (rows, columns, diagonals) on the board" do
      new_board = TicTacToeBoard.new(["X","O", "X", "X", "X", "O", "O", "O", "X"])
      expect(new_board.all_lines).to eq [["X", "O", "X"], ["X", "X", "O"],["O", "O", "X"], ["X", "X", "O"], ["O", "X", "O"], ["X", "O", "X"], ["X", "X", "X"], ["X", "X", "O"] ]
    end
  end

  describe '#empty_cells' do
    it "returns all the empty cells when there are empty cells" do
      new_board = TicTacToeBoard.new(["X","O", "X", "X", "X", "O", "", "", ""])
      expect(new_board.empty_cells).to eq [6,7,8]
    end

    it "returns an empty array when there are no empty cells" do
      new_board = TicTacToeBoard.new(["X","O", "X", "X", "X", "O", "X", "X", "O"])
      expect(new_board.empty_cells).to eq []
    end
  end

  describe "#available_corners" do
    it "returns an empty array when there are no available corners" do
      new_board = TicTacToeBoard.new(["X","O", "X", "X", "X", "O", "X", "X", "O"])
      expect(new_board.available_corners).to eq []
    end

    it "returns an array all available corners when there are some" do
      new_board = TicTacToeBoard.new(["","O", "X", "X", "X", "O", "", "X", "O"])
      expect(new_board.available_corners).to eq [0, 6]
    end
  end

  describe "#center_available" do
    it "returns true when the center is available" do
      new_board = TicTacToeBoard.new(["","O", "X", "X", "", "O", "", "X", "O"])
      expect(new_board.center_available?).to be true
    end

    it "returns false when the center is not available" do
      new_board = TicTacToeBoard.new(["","O", "X", "X", "X", "O", "", "X", "O"])
      expect(new_board.center_available?).to be false
    end
  end

  describe "#lines_that_contain_cell" do
    it "returns an array of the row, column, and any diagonals that contain the center" do
      new_board = TicTacToeBoard.new(["X","O", "X", "X", "X", "O", "O", "O", "X"])
      expect(new_board.lines_that_contain_cell(4)).to eq [ ["X", "X", "O"], ["O", "X", "O"], ["X", "X", "X"], ["X", "X", "O"] ]
    end

    it "returns an array of the row, column, and any diagonals that contain a corner" do
      new_board = TicTacToeBoard.new(["X","O", "X", "X", "X", "O", "O", "O", "X"])
      expect(new_board.lines_that_contain_cell(0)).to eq [["X", "O", "X"], ["X", "X", "O"], ["X", "X", "X"]]
    end

    it "returns an array of the row, column, and any diagonals that contain a side cell" do
      new_board = TicTacToeBoard.new(["X","O", "X", "X", "X", "O", "O", "O", "X"])
      expect(new_board.lines_that_contain_cell(1)).to eq  [["X", "O", "X"], ["O", "X", "O"]]
    end
  end


end
