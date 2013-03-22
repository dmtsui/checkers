require 'debugger'
require 'colorize'
class Piece
	attr_accessor :color, :board, :king, :display

	def initialize(color, loc, board)
		#debugger
		@color = color
		@display = " O ".colorize(@color)
		@board = board
		#debugger
		self.location = loc
		#puts "location #{@location.piece} has #{@location.piece.class}"
	end

	def move(pos)
		#dubugger
		if space_open?(pos) and right_direction?(pos) and 
			@location.neighbors.include?(@board.spaces[pos[0]][pos[1]])
			#debugger
			self.location = @board.spaces[pos[0]][pos[1]]
			king?(pos)
		elsif valid_move?(pos)
			#debugger
			jump_space = get_jump_space(pos)
			capture_piece(jump_space)
			self.location = @board.spaces[pos[0]][pos[1]]
			king?(pos)
		else
				puts "Not a valid move!"
		end
	end

	def location
		@location.position
	end

	def location=(loc)
		@location.piece = nil if !@location.nil?
		@location = loc
		@location.piece = self
		#debugger
		#puts "location #{@location.piece.location} has #{@location.piece.class}"
	end


	def space_open?(pos)
		#debugger
		@board.spaces[pos[0]][pos[1]].piece.nil?
	end

	def capture?(jump_space)
		#debugger
		jump_space.piece.color != @color
	end

	def capture_piece(jump_space)
		piece_set = (jump_space.piece.color == :red) ? @board.red_pieces : @board.black_pieces
			piece_set.delete(jump_space.piece)
			jump_space.piece = nil
	end

	def get_jump_space(pos)
		#debugger
		jump_space = @board.spaces[pos[0]][pos[1]].neighbors & @location.neighbors
		#debugger
		jump_space.count == 1 and jump_space[0].piece and capture?(jump_space[0])? jump_space[0] : nil	
	end

	def valid_move?(pos)
		#debugger
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
		#debugger
		return true if @king
		@color == :black ? pos[0] > location[0] : pos[0] < location[0]
	end
end