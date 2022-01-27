require_relative 'movement.rb'
require 'singleton'

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

class Bishop < Piece
    include Slideable
    def initialize(color, board, current_pos)
        super(color, board, current_pos)
        @type = :bishop
        @symbol = :B
    end

    def move_dirs
        moves(:bishop)
    end

    def dupe(dup_board)
        Bishop.new(@color, dup_board, @current_pos)
    end
end

class Rook < Piece
    include Slideable
    def initialize(color, board, current_pos)
        super(color, board, current_pos)
        @type = :rook
        @symbol = :R
    end

    def move_dirs
        moves(:rook)
    end

    def dupe(dup_board)
        Rook.new(@color, dup_board, @current_pos)
    end
end

class Queen < Piece
    include Slideable
    def initialize(color, board, current_pos)
        super(color, board, current_pos)
        @type = :queen
        @symbol = :Q
    end

    def move_dirs
        moves(:queen)
    end

    def dupe(dup_board)
        Queen.new(@color, dup_board, @current_pos)
    end
end

class Knight < Piece
    include Stepable

    def initialize(color, board, current_pos)
        super(color, board, current_pos)
        @type = :knight
        @symbol = :H # horsey
    end
    
    def dupe(dup_board)
        Knight.new(@color, dup_board, @current_pos)
    end
end

class King < Piece
    include Stepable
    def initialize(color, board, current_pos)
        super(color, board, current_pos)
        @type = :king
        @symbol = :K
    end

    def dupe(dup_board)
        King.new(@color, dup_board, @current_pos)
    end
end

class Pawn < Piece
    include Pawnable

    def initialize(color, board, current_pos)
        super(color, board, current_pos)
        @type = :pawn
        @symbol = :P
    end

    def at_start_row?
        row, col = @current_pos
        ( @color == :white && row == 6 ) || ( @color == :black && row == 1 )
    end

    def dupe(dup_board)
        Pawn.new(@color, dup_board, @current_pos)
    end

end

class Nullpiece < Piece
    include Singleton
    attr_reader :color, :symbol
    def initialize
        @symbol = :_
    end
end