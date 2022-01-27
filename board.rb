require_relative 'nullpiece.rb'
require_relative 'pawn.rb'
require_relative 'sliding_piece.rb'
require_relative 'stepping_piece.rb'

require 'colorize'

class Board
    attr_reader :board

    def initialize
        @board = Array.new(8) { Array.new(8) {Nullpiece.instance} }
        self.populate!
    end

    def populate!
        (0..7).each do |row|
            (0..7).each do |col|
                if row == 0
                    @board[row][col] = Rook.new(:black, @board, [row, col]) if col == 0 || col == 7
                    @board[row][col] = Knight.new(:black, @board, [row, col]) if col == 1 || col == 6
                    @board[row][col] = Bishop.new(:black, @board, [row, col]) if col == 2 || col == 5
                    @board[row][col] = King.new(:black, @board, [row, col]) if col == 3
                    @board[row][col] = Queen.new(:black, @board, [row, col]) if col == 4
                elsif row == 1
                    @board[row][col] = Pawn.new(:black, @board, [row, col])
                elsif row == 6
                    @board[row][col] = Pawn.new(:white, @board, [row, col])
                elsif row == 7
                    @board[row][col] = Rook.new(:white, @board, [row, col]) if col == 0 || col == 7
                    @board[row][col] = Knight.new(:white, @board, [row, col]) if col == 1 || col == 6
                    @board[row][col] = Bishop.new(:white, @board, [row, col]) if col == 2 || col == 5
                    @board[row][col] = King.new(:white, @board, [row, col]) if col == 3
                    @board[row][col] = Queen.new(:white, @board, [row, col]) if col == 4
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
        raise "There is no piece at start_pos!" if self[start_pos].is_a?(Nullpiece)
        raise "Invalid end_pos!" if !self.view_moves(start_pos).include? end_pos
        raise "end_pos is occupied by a teammate!" if self[start_pos].color == self[end_pos].color

        self[end_pos] = self[start_pos]
        self[end_pos].pos = end_pos
        self[start_pos] = Nullpiece.instance
        true
    end

    def view_moves(pos)
        piece = self[pos]
        if piece.is_a? Pawn
            piece.moves
        elsif piece.is_a?(Knight) || piece.is_a?(King)
            piece.move_diffs
        elsif piece.is_a?(Bishop) || piece.is_a?(Rook) || piece.is_a?(Queen)
            piece.move_dirs
        end
    end

end