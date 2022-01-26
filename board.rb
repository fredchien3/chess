require_relative 'piece.rb'
require 'colorize'

class Board
    def initialize
        @board = Array.new(8) { Array.new(8) }
        self.populate!
    end

    def populate!
        (0..7).each do |row|
            (0..7).each do |col|
                if row == 0 || row == 7 
                    @board[row][col] = Piece.new(:rook) if col == 0 || col == 7
                    @board[row][col] = Piece.new(:knight) if col == 1 || col == 6
                    @board[row][col] = Piece.new(:bishop) if col == 2 || col == 5
                    @board[row][col] = Piece.new(:king) if col == 3
                    @board[row][col] = Piece.new(:queen) if col == 4
                elsif row == 1 || row == 6
                    @board[row][col] = Piece.new(:pawn)
                else
                    @board[row][col] = Piece.new
                end
            end
        end
    end


    def [](pos)
        row, col = pos
        @board[row][col]
    end
    
    def []=(pos, val)
        row, col = pos
        @board[row][col] = val
    end

    def move_piece(start_pos, end_pos)
        # raise "There is no piece at start_pos" if @board[row][col].is_a? NullPiece
        # check if end_pos is included in the piece's allowed moves list
        # raise "Cannot move to end_pos" if @board[row][col

        self[end_pos] = self[start_pos]
        self[start_pos] = nil
    end
end