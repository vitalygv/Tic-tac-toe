require_relative "constants.rb"

module TicTacToe
  class Board
    WINNING_COMBINATIONS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]].freeze
    LAST_INDEX_OF_FIRST_ROW = 2
    LAST_INDEX_OF_SECOND_ROW = 5

    def initialize(board: [1, 2, 3, 4, 5, 6, 7, 8, 9])
      @board = board
    end
  
    attr_reader :board

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
  
    def player_moves(sign)
      board.each_with_object([]).with_index do |(board_cell, moves), index|
        if board_cell == sign 
          moves << index + 1
        end
      end
    end

    def put_sign(player_move, sign)
      @board[player_move - 1] = sign
    end
  
    def winner?(sign)
      WINNING_COMBINATIONS.any? do |winning_combination|
        (winning_combination - player_moves(sign)).empty?
      end
    end
  end
end
