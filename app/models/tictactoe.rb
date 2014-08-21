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
  attr_accessor :opponent, :game_board

  def initialize(marker)
    @marker = marker
    @opponent = nil
    @game_board = nil
  end

  def play_cell(num)
    game_board.new_play({cell_num: num, marker: marker})
  end

  def random_play
    cell_num = game_board.empty_cells.sample
    play_cell(cell_num)
  end

  # def find_opponent
  #   Player.new((game_board.board - [marker]).flatten.first)
  # end

  def smart_play
    opponent = find_opponent
    cell_num = nil
    # unless game_board.finished?
      if find_winning_cells != []
        puts "win"
        cell_num = find_winning_cells.first       
      elsif opponent.find_winning_cells != []
        puts "block"
        cell_num = opponent.find_winning_cells.first
      elsif find_forks != []
        puts "fork"
        cell_num = find_forks.first
      elsif opponent.find_forks != []
        puts "block fork"
        cell_num = block_fork(opponent.find_forks)
      elsif game_board.center_available?
        puts "center"
        cell_num = 4
      elsif opponent.find_opposite_corner
        puts "opp corner"
        cell_num = opponent.find_opposite_corner
      elsif game_board.available_corners != []
        cell_num = game_board.available_corners.sample
        puts "corner"
      else
        puts "random"
        return random_play
      end

      return play_cell(cell_num)
    # end
  end

  def find_winning_cells
    winning_cells = []
    game_board.empty_cells.each do |cell_num|
      game_board.lines_that_contain_cell(cell_num).each do |line|
        if line.join == marker + marker
          winning_cells << cell_num
        end
      end
    end
    winning_cells
  end

  # def find_forks
  #   forks = []
  #   cells = []
  #   game_board.board.each_with_index do |cell, index|
  #     if cell == marker
  #       cells << index
  #     end
  #   end

  #   cells.each do |cell|
  #     count = 0
  #     game_board.lines_that_contain_cell(cell).each do |line|
  #       count +=1 if line.join == marker + marker
  #     end
  #     if count > 1
  #       forks << cell
  #     end    
  #   end
  #   forks
  # end
  def find_forks
    forks = []
    game_board.empty_cells.each do |cell|
      hypothetical_board = TicTacToeBoard.new(game_board.board.dup)
      hypothetical_board.new_play({marker: marker, cell_num: cell})
      this_player_copy = Player.new(marker)
      opponent_copy = Player.new(opponent.marker)
      hypo_game = TicTacToeGame.new({board: hypothetical_board, player1: this_player_copy, player2: opponent_copy })
      if this_player_copy.find_winning_cells.length > 1
        forks << cell
      end
    end
    forks
  end

  def find_opposite_corner
    game_board.available_corners.each do |cell_num|
      if game_board.board[8 - cell_num] == marker
        return cell_num
      end
    end
    nil
  end

  # def block_fork
  #   game_board.empty_cells.each do |cell_num|
  #     test_board = game_board.board.dup
  #     test_board[cell_num] = opponent
  #     test_game = Game.new({board: test_board})
  #     unless test_game.forks(opponent).empty?
  #       puts 'blah'
  #       empty_cells.each do |cell_num2|
  #         remaining_cells = empty_cells.select{|cell| cell != cell_num2}

  #         second_test_board = board.dup
  #         second_test_board[cell_num2] = player
  #         second_test_game = Game.new({board: second_test_board})

  #         possible = true

  #         remaining_cells.each do |cell|
  #           third_test_board = second_test_board.dup
  #           third_test_board[cell] = opponent
  #           third_test_game = Game.new({board: third_test_board})
  #           unless third_test_game.forks(opponent).empty?
  #             possible = false unless third_test_game.winning_cell(player)
  #           end
  #         end

  #         if possible
  #           return cell_num2
  #         end
  #       end
  #     end
  #   end
  #   false
  # end
  def block_fork(cells_to_block)
    game_board.empty_cells.each do |cell|
      hypothetical_board = TicTacToeBoard.new(game_board.board.dup)
      hypothetical_board.new_play({marker: marker, cell_num: cell})
      this_player_copy = Player.new(marker)
      opponent_copy = Player.new(opponent.marker)
      hypothetical_game = TicTacToeGame.new({board: hypothetical_board, player1: this_player_copy, player2: opponent_copy})

      if this_player_copy.find_winning_cells != []
        forces_opponent_fork = cells_to_block & this_player_copy.find_winning_cells != []
        unless forces_opponent_fork
          return cell
        end
      end
    end
    return cells_to_block.first
  end
end

class TicTacToeGame 
  attr_reader :winning_marker, :board
  def initialize(args)
    @board = args[:board]
    @player1 = args[:player1]
    @player2 = args[:player2]
    setup_game
  end

  def setup_game
    @player1.opponent, @player2.opponent = @player2, @player1
    @player1.game_board = @board
    @player2.game_board = @board
    @winning_marker = find_winner
  end

  def finished?
    return true if board.empty_cells.length == 0
    find_winner != nil 
  end

  def find_winner
    board.all_lines.each do |line|
      unless line.join.scan(/((.)\2{2})/) == []
        return line.join.gsub(/((.)\2{2})/, '\2')
      end
    end
    nil
  end

  # valid play?

end