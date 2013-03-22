class SpaceNode
	attr_accessor :contains, :color, :neighbors, :position

	def initialize(color)
		@neighbors = []
		@color = color
	end

	def add_neighbors
		row, col = self.position 
		diagonal_spaces = [[1,-1],[1,1],[-1,-1],[-1,1]]
		

	end
end