require 'byebug'

module Slideable

    DIAGONAL_DIRS = [
        [-1, -1],    # up_left
        [-1, +1],    # up_right
        [+1, -1],    # down_left
        [+1, +1]    # down_right
        ]

    HORIZONTAL_DIRS = [
        [-1, 0],     # up
        [1, 0],      # down
        [0, -1],     # left
        [0, 1]      # right
        ]

    def moves(directions) # straight, diag, both
        case directions
        when :bishop
            moves = self.diagonal_directions
        when :rook
            moves = self.horizontal_directions
        when :queen
            moves = self.diagonal_directions + self.horizontal_directions
        end
        moves
    end

    def diagonal_directions
        diagonals = Array.new
            
        DIAGONAL_DIRS.each do |direction|
            array = explore_direction(@current_pos, direction) 
            diagonals += array if array
        end

        diagonals
    end

    def explore_direction(current_pos, direction)
        # recursively adds moves to the direction
        # unless OOB, teammate, or beyond enemy.
        directional_moves = Array.new
        dy, dx = direction

        crow, ccol = current_pos
        nrow, ncol = crow+dy, ccol+dx
        next_pos = [nrow, ncol]
        
        return if next_pos.any? { |coord| !coord.between?(0, 7) }   # out of bounds
        return if @board[next_pos].color == self.color  # teammate
        
        if @board[next_pos].color && @board[next_pos].color != self.color # enemy
            return [next_pos]
        end

        directional_moves << next_pos

        recursive = explore_direction(next_pos, direction)
        directional_moves += recursive if recursive
        directional_moves
    end

    def horizontal_directions
        row, col = @current_pos
        horizontals = Array.new

        HORIZONTAL_DIRS.each do |direction|
            array = explore_direction(@current_pos, direction) 
            horizontals += array if array
        end
        
        horizontals
    end

end

module Stepable
    KNIGHT_MOVES = [
        [-2, -1],
        [-2,  1],
        [-1, -2],
        [-1,  2],
        [ 1, -2],
        [ 1,  2],
        [ 2, -1],
        [ 2,  1]
      ]
      
    KING_MOVES = [
        [-1, -1],
        [-1,  0],
        [-1,  1],
        [ 0, -1],
        [ 0,  1],
        [ 1, -1],
        [ 1,  0],
        [ 1,  1]
      ]
    
    def moves(type)
        moves = Array.new
        row, col = @current_pos

        case type
        when :knight
            KNIGHT_MOVES.each do |dy, dx|
                
                move = [row + dy, col + dx]
                moves << move if move.all? { |coord| coord.between?(0,7) }
            end
        when :king
            KING_MOVES.each do |dy, dx|
                move = [row + dy, col + dx]
                moves << move if move.all? { |coord| coord.between?(0,7) }
            end
        end
        moves
    end

end

module Pawnable
    def moves(type)
        moves = self.forward_steps + self.side_attacks
        moves.reject! do |pos|
            @board[pos].color == self.color
        end
        moves
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
        ld_pos = [row + dy, col - 1]
        rd_pos = [row + dy, col + 1]
        
        left_diag = @board[ld_pos]
        right_diag = @board[rd_pos]


        attacks << [row + dy, col - 1] if left_diag && !left_diag.is_a?(Nullpiece) && left_diag.color != self.color
        attacks << [row + dy, col + 1] if right_diag && !right_diag.is_a?(Nullpiece) && right_diag.color != self.color

        attacks
    end
end