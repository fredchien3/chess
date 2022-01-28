require_relative 'board.rb'
require_relative 'cursor.rb'
require 'colorize'

class Display
    attr_accessor :cursor

    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0], board)
        true
    end

    def render(current_player=nil)
        system('clear')
        self.print_top_line
        
        (0..7).each do |row|
            print (row.to_s + " ").light_blue # print side line
            (0..7).each do |col|
                pos = row, col

                if row.even? && col.even? || row.odd? && col.odd?
                    argument = {:color => :white, :background => :light_black}
                else
                    argument = {:color => :white, :background => :dark_white}
                end

                if pos == @cursor.cursor_pos
                    @cursor.selected ? argument = {:color => :black, :background => :red} : argument = {:color => :white, :background => :green}
                end
                
                if @board[pos].symbol == :_
                    print "  ".colorize(argument)
                else
                    print (@board[pos].symbol.to_s + " ").colorize(argument)
                end

            end
            puts
        end
        if current_player
            puts "Current player: #{current_player.name}"         
            current_player.color == :white ? (print "Pieces: Transparent | Side: Bottom") : (print "Pieces: Solid | Side: Top")
            puts
            puts "Press arrow keys or WASD to move cursor"
            puts "Press space or enter to select, ctrl + c to quit"
        else
            puts "Welcome!"
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

    # def loopy
    #     50.times do
    #         self.render
    #         @cursor.get_input
    #     end
    # end

end