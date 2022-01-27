require_relative 'piece.rb'

class Pawn < Piece
    include Pawnable

    def initialize(color, board, current_pos)
        super(color, board, current_pos)
        @type = :pawn
        @symbol = :P
    end

    # def valid_moves
    #     moves = self.forward_steps + self.side_attacks
    #     moves.reject! do |pos|
    #         # row, col = pos
    #         @board[pos].color == self.color
    #     end
    #     moves
    # end

    def at_start_row?
        row, col = @current_pos
        ( @color == :white && row == 6 ) || ( @color == :black && row == 1 )
    end

    def dupe(dup_board)
        Pawn.new(@color, dup_board, @current_pos)
    end

end