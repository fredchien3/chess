require_relative 'piece.rb'

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
end