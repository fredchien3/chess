require_relative 'piece.rb'
require 'byebug'

class Pawn < Piece
    def initialize(color, board, current_pos)
        super(color, board, current_pos)
        @type = :pawn
        @symbol = :P
    end
    
    def valid_moves
        moves = self.forward_steps + self.side_attacks
        moves.reject! do |pos|
            row, col = pos
            @board[row][col].color == self.color
        end
        moves
    end

    def at_start_row?
        row, col = @current_pos
        ( @color == :white && row == 6 ) || ( @color == :black && row == 1 )
    end

    def forward_dir
        @color == :white ? (return -1) : (return 1)
    end

    def forward_steps
        steps = Array.new
        row, col = @current_pos

        if self.at_start_row?
            dy = self.forward_dir
            steps << [row + dy, col]
            steps << [row + (dy*2), col]
        else
            dy = self.forward_dir
            steps << [row + dy, col]
        end
        steps
    end

    def side_attacks
        attacks = Array.new

        row, col = @current_pos
        dy = self.forward_dir
        
        left_diag = @board[row + dy][col - 1]
        right_diag = @board[row + dy][col + 1]


        attacks << [row + dy, col - 1] if left_diag && !left_diag.is_a?(Nullpiece) && left_diag.color != self.color
        attacks << [row + dy, col + 1] if right_diag && !right_diag.is_a?(Nullpiece) && right_diag.color != self.color

        attacks
    end

end