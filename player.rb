class Player
  attr_accessor :color, :board, :player_pieces
  def initialize(color, player_pieces, board)
    @color = color
    @player_pieces = player_pieces
  end

  def input
    puts "#{self.color.capitalize} player pick your play: "
    puts "From: example a2"
    piece_location = input_to_coordinates(gets.chomp.downcase.split(//))
    puts "To: example a4"
    move_to_location = input_to_coordinates(gets.chomp.downcase.split(//))
    return piece_location, move_to_location
  end


  def available_moves?
    @player_pieces.each do |piece|
      return true if piece.can_move?
    end
    return false
  end

  def input_to_coordinates(input)
    col = input[0].ord - 97
    row = input[1].to_i - 1
    [row, col]
  end

end