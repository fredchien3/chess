require_relative 'movement.rb'

class Piece
    attr_reader :type, :current_pos, :color, :symbol

    def initialize(color, board, current_pos)
        @color = color
        @board = board
        @current_pos = current_pos
    end

    def inspect
        @symbol.inspect
        # @color.inspect
    end

    def pos=(pos)
        @current_pos = pos
    end
end
