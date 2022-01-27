require_relative 'piece.rb'

class Knight < Piece
    include Stepable
    def initialize(color, board, current_pos)
        super(color, board, current_pos)
        @type = :knight
        @symbol = :H # horsey
    end
    
    # def move_diffs
    #     moves(:knight)
    # end
end

class King < Piece
    include Stepable
    def initialize(color, board, current_pos)
        super(color, board, current_pos)
        @type = :king
        @symbol = :K
    end

    # def move_diffs
    #     moves(:king)
    # end
end