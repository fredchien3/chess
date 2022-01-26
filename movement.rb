module Slideable
    def moves(directions) # straight, diag, both
        moves = Set.new
        row, col = @current_pos

        case directions
        when :diag
            (0..7).each do |n|
                # up_left = [row - n, col - n]
                # up_right = [row - n, col + n]
                # down_left = [row + n, col - n]
                # down_right = [row + n, col + n]
                pairs = [[row - n, col - n],
                [row - n, col + n],
                [row + n, col - n],
                [row + n, col + n]]
                
                pairs.each do |pair|
                    moves << pair if pair.all? { |coord| coord.between?(0,7) }
                end
            end
            moves.delete(@current_pos)
        when :straight
            (0..7).each do |nrow|
                (0..7).each do |ncol|
                    moves << [nrow, ncol] if nrow == row
                    moves << [nrow, ncol] if ncol == col
                end
            end
            moves.delete(@current_pos)
        end
        moves
    end
end

module Stepable
    
end