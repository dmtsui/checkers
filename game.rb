require "colorize"
require './board.rb'
require 'debugger'
require './player.rb'
class Checker
	attr_accessor :red_player, :black_player, :board

	def initialize
		@board = Board.new
		@red_player = Player.new(:red, @board)
		@black_player = Player.new(:black, @board)
	end

	def play
		#debugger
		draw_screen
		while true
			play_cycle
		end
		#@board.red_pieces.each {|piece| p piece.location }
		#@board.black_pieces.each {|piece| p piece.location}

	end

	def play_cycle
	start, move_to = @black_player.input
	#debugger
	@board.spaces[start[0]][start[1]].piece.move(move_to)
	#debugger
	draw_screen
	# start, move_to = @red_player.input
	# @board.spaces[start[0]][start[1]].piece.move(move_to)
	# @board.draw_screen
	end

	def draw_screen
	system('clear')
	screen_array = []
	8.times do |row|
	  temp_row = []
	  8.times do |col|
	  	#debugger
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
	puts "red_pieces : #{@board.red_pieces.count} black_pieces : #{@board.black_pieces.count}"
	end

end

game = Checker.new
game.play