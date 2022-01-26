require_relative 'movement.rb'

class Piece
    attr_reader :type, :current_pos

    def initialize(color, board, current_pos)
        @color = color
        @board = board
        @current_pos = current_pos
    end

    # def inspect
    #     @symbol.inspect
    # end
end
