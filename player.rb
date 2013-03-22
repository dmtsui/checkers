class Player
  attr_accessor :color, :board
  def initialize(color, board)
    @color = color
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

  end

  def input_to_coordinates(input)
    col = input[0].ord - 97
    row = input[1].to_i - 1
    [row, col]
  end

end