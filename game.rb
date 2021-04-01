require_relative "board.rb"
require_relative "constants.rb"

module TicTacToe
  class Game
    GAME_LENGTH = 9
    INITIAL_TURN = 1

    def initialize(board: Board.new, turn: INITIAL_TURN, current_sign: TicTacToe::Constants::X_SIGN) 
      @board = board
      @turn = turn
      @current_sign = current_sign
    end
  
    def play
      @board.show_board
  
      while @turn <= GAME_LENGTH
        make_move
        @board.show_board
        return p "Wins player #{@current_sign}" if @board.winner?(@current_sign)
      end
      p "Draw"
    end

    private

    def switch_players
      @current_sign = @turn.odd? ? TicTacToe::Constants::X_SIGN : TicTacToe::Constants::O_SIGN
    end
  
    def current_player_moves
      @board.player_moves(@current_sign)
    end

    def make_move
      switch_players
      player_move = acquire_player_move
      @board.put_sign(player_move, @current_sign)
      @turn += 1
    end
  
    def acquire_player_move
      puts "Make your move player #{@current_sign}"
      loop do
        player_move = gets.chomp.to_i
        break player_move if ![TicTacToe::Constants::X_SIGN, TicTacToe::Constants::O_SIGN].include?(@board.board[player_move - 1]) && (1..9).include?(player_move)
        puts 'NO'
        puts "Make your move again player #{@current_sign}"
      end
    end
  end
end
