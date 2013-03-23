require 'debugger'
class SpaceNode
	attr_accessor :piece, :color, :neighbors, :position, :board

	def initialize(color, position, board)
		@neighbors = []
		@position = position
		@color = color
		@board = board
		
	end

	def add_neighbors
		pr, pc = @position 
		diagonals = [[1,-1],[1,1],[-1,-1],[-1,1]]
		diagonals.select do |r,c| 
			@neighbors << @board.spaces[pr+r][pc+c] if (0..7).include?(pr+r) and (0..7).include?(pc+c)
		end
		nil
	end
end