module Slideable

    def moves(directions) # straight, diag, both
        case directions
        when :diag
            moves = self.diagonal_directions
        when :straight
            moves = self.horizontal_directions
        when :both
            moves = self.diagonal_directions + self.horizontal_directions
        end
        moves
    end

    def diagonal_directions
        row, col = @current_pos
        diagonals = Set.new
        (0..7).each do |n|
            pairs = [[row - n, col - n],
            [row - n, col + n],
            [row + n, col - n],
            [row + n, col + n]]
            
            pairs.each do |pair|
                diagonals << pair if pair.all? { |coord| coord.between?(0,7) }
            end
        end
        diagonals.delete(@current_pos)
    end

    def horizontal_directions
        row, col = @current_pos
        horizontals = Set.new
        (0..7).each do |nrow|
            (0..7).each do |ncol|
                horizontals << [nrow, ncol] if nrow == row
                horizontals << [nrow, ncol] if ncol == col
            end
        end
        horizontals.delete(@current_pos)
    end

end

module Stepable
    def moves()
    end
end