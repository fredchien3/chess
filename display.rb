require_relative 'board.rb'
require_relative 'cursor.rb'
require 'colorize'

class Display
    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0], board)
    end

    def render
        self.print_top_line
        
        (0..7).each do |row|
            print (row.to_s + " ").light_blue # print side line
            (0..7).each do |col|
                pos = row, col
                argument = {:color => :black, :background => :white} if row.even? && col.even? || row.odd? && col.odd?
                
                print (@board[pos].symbol.to_s + " ").colorize(argument)

            end
            puts
        end
    end

    def print_top_line
        print "  "
        (0..7).each do |i|
            square = i.to_s + " "
            print square.light_blue
        end
        puts
    end

end