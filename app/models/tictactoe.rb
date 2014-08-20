class TicTacToeBoard
  attr_reader :board
  def initialize(board)
    @board = board
  end

  def new_play(args)
    board[args[:cell_num]] = args[:marker] if board[args[:cell_num]] == ""
  end

  def all_lines
    rows + cols + diags
  end

  def empty_cells
    empty_cells = []
    board.each_with_index do |cell, index|
      if cell == ""
        empty_cells << index
      end
    end
    empty_cells
  end

  def available_corners
    empty_cells & [0, 2, 6, 8]
  end

  def center_available?
    empty_cells.include?(4)
  end

  # def winning_cell(player_marker)
  #   empty_cells.each do |cell_num|
  #     lines_that_contain_cell(cell_num).each do |line|
  #       if line.join == player_marker + player_marker
  #         return cell_num
  #       end
  #     end
  #   end
  #   nil
  # end

  # def forks(player_marker)
  #   forks = []
  #   cells = []
  #   board.each_with_index do |cell, index|
  #     if cell == player_marker
  #       cells << index
  #     end
  #   end

  #   cells.each do |cell|
  #     count = 0
  #     lines_that_contain_cell(cell).each do |line|
  #       count +=1 if line.join == player_marker + player_marker
  #     end
  #     if count > 1
  #       forks << cells
  #     end    
  #   end
  #   forks
  # end
  
  # def opposite_corner_available(player_marker)
  #   available_corners.each do |cell_num|
  #     if board[8 - cell_num] == player_marker
  #       return cell_num
  #     end
  #   end
  #   nil
  # end

  # def cell_to_block(player = "O")
  #   opponent = player == "O" ? "X" : "O"
  #   empty_cells.each do |cell_num|
  #     new_board = board.dup
  #     new_board[cell_num] = opponent
  #     if Game.new({board: new_board}).winner == opponent
  #       return cell_num
  #     end
  #   end
  #   nil
  # end

  

  # def look_for_fork(player = "O")
  #   opponent = player == "O" ? "X" : "O"
  #   empty_cells.each do |cell_num|
  #     test_board = board.dup
  #     test_board[cell_num] = player
  #     test_game = Game.new({board: test_board})

  #     unless test_game.forks?(player).empty?
  #       return cell_num
  #     end
  #   end
  #   false
  # end

  def lines_that_contain_cell(cell_num)
    row = rows[cell_num / 3]
    col = cols[cell_num % 3]
    lines = [row, col]

    if [0,4,8].include?(cell_num)
      lines << diags[0]
    end

    if [2,4,6].include?(cell_num)
      lines << diags[1]
    end    
    lines
  end

  private
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
  
end



class Player
  attr_reader :marker
  attr_accessor :opponent, :game

  def initialize(marker)
    @marker = marker
    @opponent = nil
    @game = nil
  end

  def play_cell(num)
    game.new_play({cell_num: num, marker: marker})
  end

  def random_play
    unless game.finished?
      cell_num = game.empty_cells.sample
      play_cell(cell_num)
    end
  end

  def smart_play
    cell_num = nil
    unless game.finished?
      if find_winning_cell
        puts "win"
        cell_num = find_winning_cell       
      elsif opponent.find_winning_cell
        puts "block"
        cell_num = opponent.find_winning_cell
      elsif find_forks != []
        puts "fork"
        cell_num = find_forks.first
      elsif opponent.find_forks != []
        puts "block fork"
        cell_num = block_fork
      elsif game.center_available?
        puts "center"
        cell_num = 4
      elsif opponent.find_opposite_corner
        puts "opp corner"
        cell_num = opponent.find_opposite_corner
      elsif game.available_corners != []
        cell_num = game.available_corners.sample
        puts "corner"
      else
        puts "random"
        return random_play
      end

      return play_cell(cell_num)
    end
  end

  def find_winning_cell
    game.empty_cells.each do |cell_num|
      game.lines_that_contain_cell(cell_num).each do |line|
        if line.join == player_marker + player_marker
          return cell_num
        end
      end
    end
    nil
  end

  def find_forks
    forks = []
    cells = []
    game.board.each_with_index do |cell, index|
      if cell == marker
        cells << index
      end
    end

    cells.each do |cell|
      count = 0
      game.lines_that_contain_cell(cell).each do |line|
        count +=1 if line.join == player_marker + player_marker
      end
      if count > 1
        forks << cells
      end    
    end
    forks
  end

  def find_opposite_corner
    game.available_corners.each do |cell_num|
      if game.board[8 - cell_num] == marker
        return cell_num
      end
    end
    nil
  end

  def block_fork
    game.empty_cells.each do |cell_num|
      test_board = board.dup
      test_board[cell_num] = opponent
      test_game = Game.new({board: test_board})
      unless test_game.forks(opponent).empty?
        puts 'blah'
        empty_cells.each do |cell_num2|
          remaining_cells = empty_cells.select{|cell| cell != cell_num2}

          second_test_board = board.dup
          second_test_board[cell_num2] = player
          second_test_game = Game.new({board: second_test_board})

          possible = true

          remaining_cells.each do |cell|
            third_test_board = second_test_board.dup
            third_test_board[cell] = opponent
            third_test_game = Game.new({board: third_test_board})
            unless third_test_game.forks(opponent).empty?
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

end

class TicTacToeGame 
  def initialize(args)
    @gameBoard = args[:board]
    @player1 = args[:player1]
    @player2 = args[:player2]
    @player1.opponent, @player2.opponent = @player2, @player1
    @player1.game, @player2.game = @gameBoard
    @winner = find_winner
  end

  def finished?
    return true if gameBoard.empty_cells.length == 0
    find_winner != nil 
  end

  def find_winner
    gameBoard.all_lines.each do |line|
      unless line.join.scan(/((.)\2{2})/) == []
        return line.join.gsub(/((.)\2{2})/, '\2')
      end
    end
    nil
  end

  # valid play?

  private 
  attr_reader :gameBoard

end