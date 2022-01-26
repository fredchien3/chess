class Piece
    def initialize(type=nil)
        @type = type
        case type
        when nil
            @symbol = :_
        when :king
            @symbol = :K
        when :queen
            @symbol = :Q
        when :rook
            @symbol = :R
        when :knight
            @symbol = :H
        when :bishop
            @symbol = :B
        when :pawn
            @symbol = :P
        end
    end

    def inspect
        @symbol.inspect
    end

end