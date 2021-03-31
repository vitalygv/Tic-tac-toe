class Board
  WINNING_COMBINATIONS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]].freeze

  attr_accessor :board

  def initialize
    @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @turn = 1
    @current_player = 1
    @current_sign = 'x'
    @x_moves = []
    @o_moves = []
    @current_moves = []
  end

  def show_board
    screen = @board.join(' ')
    (0..@board.length - 1).each.with_index do |i, index|
      if index == 2 || index == 5
        puts @board[i]
      else print @board[i]
           print ' '
      end
    end
    puts "\n" + '-----'
  end

  def put_sign(num, sign)
    @board[num - 1] = sign
  end

  def switch_players
    if @turn.odd?
      @current_player = 1
      @current_sign = 'x'
      @current_moves = @x_moves
    else
      @current_player = 2
      @current_sign = 'o'
      @current_moves = @o_moves
    end
  end

  def move
    switch_players
    puts "Make your move player #{@current_player}"
    player_move = gets.chomp
    while @board[player_move.to_i - 1] == 'x' || @board[player_move.to_i - 1] == 'o'
      puts 'NO'
      puts "Make your move again player #{@current_player}"
      player_move = gets.chomp
    end
    put_sign(player_move.to_i, @current_sign)
    @current_moves.push(player_move.to_i)
    p @current_moves
    p @x_moves
    p @o_moves
    @turn += 1
  end

  def winner?
    WINNING_COMBINATIONS.each do |arr|
      if (arr - @current_moves).empty?
        return true
      end
    end
    false
  end

  def play
    while @turn < 10
      move
      show_board
     if winner?
       p "Wins player #{@current_player}" 
       return
     end
    end
  end
end

board = Board.new
board.show_board
board.play
