class GameBoard
  WINNING_COMBINATIONS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]].freeze
  GAME_LENGTH = 9
  LAST_INDEX_OF_FIRST_ROW = 2
  LAST_INDEX_OF_SECOND_ROW = 5
  X_SIGN = "x"
  O_SIGN = "o"

  def initialize(board: [1, 2, 3, 4, 5, 6, 7, 8, 9], turn: 1, current_sign: X_SIGN, x_moves: [], o_moves: [])
    @board = board
    @turn = turn
    @current_sign = current_sign
    @x_moves = x_moves
    @o_moves = o_moves 
  end

  def play
    show_board

    while @turn <= GAME_LENGTH
      make_move
      show_board
      return p "Wins player #{@current_sign}" if winner?(current_player_moves)
    end
    p "Draw"
  end

  private

  def show_board
    @board.each.with_index do |board_cell, index|
      if [LAST_INDEX_OF_FIRST_ROW, LAST_INDEX_OF_SECOND_ROW].include?(index)
        puts board_cell
      else 
        print board_cell
        print ' '
      end
    end
    puts "\n" + '-----'
  end

  def put_sign(player_move, sign)
    @board[player_move - 1] = sign
  end

  def switch_players
    @current_sign = @turn.odd? ? X_SIGN : O_SIGN
  end

  def current_player_moves
    @current_sign == X_SIGN ? @x_moves : @o_moves
  end

  def make_move
    switch_players
    player_move = acquire_player_move
    put_sign(player_move, @current_sign)
    @turn += 1
    current_player_moves.push(player_move)
  end

  def acquire_player_move
    puts "Make your move player #{@current_sign}"
    loop do
      player_move = gets.chomp.to_i
      break player_move unless [X_SIGN, O_SIGN].include?(@board[player_move - 1])
      puts 'NO'
      puts "Make your move again player #{@current_sign}"
    end
  end

  def winner?(current_moves)
    WINNING_COMBINATIONS.any? do |winning_combination|
      (winning_combination - current_moves).empty?
    end
  end
end

board = GameBoard.new
board.play
