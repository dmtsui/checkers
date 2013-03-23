require "colorize"
require './board.rb'
require 'debugger'
require './player.rb'
class Checker
	attr_accessor :red_player, :black_player, :board

	def initialize
		@board = Board.new
		@red_player = Player.new(:red, @board.red_pieces, @board)
		@black_player = Player.new(:black, @board.red_pieces, @board)
	end

	def play
		draw_screen
		while true
			play_turn(@black_player)
			play_turn(@red_player)
		end

	end

	def play_turn(player)
	start, move_to = player.input
	@board.spaces[start[0]][start[1]].piece.move(move_to)
	draw_screen
	puts "Win!" if win?
	player.available_moves?
	end

	def win?
		@board.red_pieces.count == 0 or @board.black_pieces.count == 0
	end

	def draw_screen
	system('clear')
	screen_array = []
	8.times do |row|
	  temp_row = []
	  8.times do |col|
	    space_render = @board.spaces[row][col].piece ? @board.spaces[row][col].piece.display : " . "
	    temp_row << space_render.colorize( :background => @board.spaces[row][col].color)
	  end
	  screen_array.unshift(temp_row)
	end
	puts "  " + ("A".."H").to_a.join("  ")
	screen_array.each_with_index do |row, index|
	  puts "#{8-index}" + row.join("") + "#{8-index}"
	end
	puts "  " + ("A".."H").to_a.join("  ")
	puts "red_can_move? #{@red_player.available_moves?} black_can_move? : #{@black_player.available_moves?}"
	puts "current move have available moves? #{@board.can_move}"
	end

end

game = Checker.new
game.play