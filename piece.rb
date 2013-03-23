require 'debugger'
require 'colorize'
class Piece
	attr_accessor :color, :board, :king, :display

	def initialize(color, loc, board)
		@color = color
		@display = " O ".colorize(@color)
		@board = board
		self.location = loc
	end

	def can_jump?(pos)
		space_open?(pos) and valid_move?(pos)
	end

	def can_move?
		@location.neighbors.each do |neighbor|
			pos = neighbor.position
			if space_open?(pos) and right_direction?(pos) and 
				@location.neighbors.include?(@board.spaces[pos[0]][pos[1]])
				return true
			end
			neighbor.neighbors.each do |jump_space|
				return true if can_jump?(jump_space.position)	
			end
		end
		return false
	end

	def move(pos)
		if space_open?(pos) and right_direction?(pos) and 
			@location.neighbors.include?(@board.spaces[pos[0]][pos[1]])
			self.location = @board.spaces[pos[0]][pos[1]]
			@board.can_move = can_move?
			king?(pos)
		elsif valid_move?(pos)
			jump_space = get_jump_space(pos)
			capture_piece(jump_space)
			self.location = @board.spaces[pos[0]][pos[1]]
			@board.can_move = can_move?
			king?(pos)
		else
				puts "Not a valid move!"
		end
	end

	def move_again(pos)
	end

	def location
		@location.position
	end

	def location=(loc)
		@location.piece = nil if !@location.nil?
		@location = loc
		@location.piece = self
	end


	def space_open?(pos)
		@board.spaces[pos[0]][pos[1]].piece.nil?
	end

	def capture?(jump_space)
		jump_space.piece.color != @color
	end

	def capture_piece(jump_space)
		piece_set = (jump_space.piece.color == :red) ? @board.red_pieces : @board.black_pieces
			piece_set.delete(jump_space.piece)
			jump_space.piece = nil
	end

	def get_jump_space(pos)
		jump_space = @board.spaces[pos[0]][pos[1]].neighbors & @location.neighbors
		jump_space.count == 1 and jump_space[0].piece and capture?(jump_space[0])? jump_space[0] : nil	
	end

	def valid_move?(pos)
		jump_space = get_jump_space(pos)
		jump_space and right_direction?(pos)
	end

	def king?(pos)
		if @color == :black ? pos[0] == 7: pos[0] == 0
			@king = true
			@display = " \u265A "
		end
	end

	def right_direction?(pos)
		return true if @king
		@color == :black ? pos[0] > location[0] : pos[0] < location[0]
	end
end