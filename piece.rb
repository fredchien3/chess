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

    def simple_moves # doesn't check for moving into check
        array = moves(@type)
        array.reject! do |pos|
            @board[pos].color == self.color
        end
        array
    end

    def valid_moves # certified hood classic
        array = self.simple_moves.reject! { |end_pos| self.move_into_check?(end_pos) }
        array ? array : []
    end

    def move_into_check?(end_pos)
        duped_board = Board.dupe(@board)
        duped_board.move_piece!(@current_pos, end_pos)
        duped_board.in_check?(self.color)
    end

end
