require './spacenode.rb'
require './piece.rb'
require 'debugger'
class Board
	attr_accessor :spaces, :red_pieces, :black_pieces

	def initialize
		@spaces = Array.new(8) {Array.new(8)}
		@red_pieces = []
		@black_pieces = []
		generate_spaces
		#debugger
		generate_pieces
		true
	end

	def generate_spaces
		8.times do |row|
			8.times do |col|
				#p "row #{row}, col #{col}"
				color = (row + col).even? ? :light_white : :light_black
				@spaces[row][col] = SpaceNode.new(color,[row,col],self)
			end
		end
		8.times do |row|
			8.times do |col|
				#puts "space on #{[row]} = #{@spaces[row][col].position}"
				@spaces[row][col].add_neighbors
			end
		end
	end

	def generate_pieces
		3.times do |row|
			8.times do |col|
				#debugger
				if (row + col) % 2 != 0
					@black_pieces <<  Piece.new(:black,@spaces[row][col],self)
				else
					@red_pieces <<  Piece.new(:red,@spaces[row+5][col],self)
				end
			end
		end

	end
end

