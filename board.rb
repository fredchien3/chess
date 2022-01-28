require_relative 'piece.rb'

class Board
    attr_reader :board, :white_king, :black_king
    attr_writer :board

    def initialize(fresh=true)
        if fresh
            @board = Array.new(8) { Array.new(8) {Nullpiece.instance} }
            self.populate! 
        else
            @board = Array.new
        end

        true
    end

    def populate!
        (0..7).each do |row|
            (0..7).each do |col|
                if row == 0
                    @board[row][col] = Rook.new(:black, self, [row, col]) if col == 0 || col == 7
                    @board[row][col] = Knight.new(:black, self, [row, col]) if col == 1 || col == 6
                    @board[row][col] = Bishop.new(:black, self, [row, col]) if col == 2 || col == 5
                    @board[row][col] = Queen.new(:black, self, [row, col]) if col == 3
                    @board[row][col] = King.new(:black, self, [row, col]) if col == 4
                elsif row == 1
                    @board[row][col] = Pawn.new(:black, self, [row, col])
                elsif row == 6
                    @board[row][col] = Pawn.new(:white, self, [row, col])
                elsif row == 7
                    @board[row][col] = Rook.new(:white, self, [row, col]) if col == 0 || col == 7
                    @board[row][col] = Knight.new(:white, self, [row, col]) if col == 1 || col == 6
                    @board[row][col] = Bishop.new(:white, self, [row, col]) if col == 2 || col == 5
                    @board[row][col] = Queen.new(:white, self, [row, col]) if col == 3
                    @board[row][col] = King.new(:white, self, [row, col]) if col == 4
                end
            end
        end
        self.track_pieces
    end

    def track_pieces
        # @black_king = @board[0][4]
        # @white_king = @board[7][4]

        # @black_team = Array.new
        # @board[0..1].each do |black_rows|
        #     black_rows.each { |piece| @black_team << piece }
        # end

        # @white_team = Array.new
        # @board[6..7].each do |white_rows|
        #     white_rows.each { |piece| @white_team << piece }
        # end

        @black_team = Array.new
        @white_team = Array.new
        @board.each do |row|
            row.each do |piece|
                if piece.color == :white
                    @white_team << piece 
                    @white_king = piece if piece.type == :king
                elsif piece.color == :black
                    @black_team << piece
                    @black_king = piece if piece.type == :king
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
        raise "end_pos not movable!" if !self.view_moves(start_pos).include? end_pos
        raise "This move would leave you in check!" if !self.view_valid_moves(start_pos).include? end_pos
        # raise "end_pos is occupied by a teammate!" if self[start_pos].color == self[end_pos].color

        @trash = self[end_pos] # for undo functionality
        @pos_1, @pos_2 = start_pos, end_pos 

        self[end_pos] = self[start_pos]
        self[end_pos].pos = end_pos
        self[start_pos] = Nullpiece.instance
        true
    end

    def move_piece!(start_pos, end_pos) # moves piece regardless of rules
        self[end_pos] = self[start_pos]
        self[end_pos].pos = end_pos
        self[start_pos] = Nullpiece.instance
        true
    end
    
    def undo_move
        self[@pos_1] = self[@pos_2]
        self[@pos_2] = @trash
        @trash = nil
    end

    def view_moves(pos)
        piece = self[pos]
        piece.simple_moves
    end

    def view_valid_moves(pos)
        piece = self[pos]
        piece.simple_moves
    end

    def in_check?(color)
        if color == :white
            king_pos = @white_king.current_pos
            opp_team = @black_team
        else
            king_pos = @black_king.current_pos
            opp_team = @white_team
        end
        
        opp_team.any? { |piece| piece.simple_moves.include? king_pos }
    end

    def checkmate?(color)
        color == :white ? team = @white_team : team = @black_team
        if in_check?(color)
            # debugger
            return team.all? { |piece| piece.valid_moves.empty? }
        end
        false
    end

    def dupe
        duped_instance = Board.new(false)
        (0..7).each do |row|
            duped_row = Array.new
            self.board[row].each do |piece|
                if piece.is_a?(Nullpiece)
                    duped_row << Nullpiece.instance
                else
                    duped_row << piece.dupe(duped_instance)
                end
            end
            duped_instance.board << duped_row
        end
        duped_instance.track_pieces
        duped_instance
    end

    def over?
        self.checkmate?(:white) || self.checkmate?(:black)
    end
    
end

