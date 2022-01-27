require_relative 'piece.rb'

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