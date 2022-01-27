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