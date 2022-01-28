require_relative 'display.rb'
require_relative 'player.rb'

class Game
    def initialize
        @board = Board.new
        @display = Display.new(@board)
        @player1 = HumanPlayer.new("ford", :white, @display)
        @player2 = HumanPlayer.new("alio", :black, @display)
        @players = [@player1, @player2]
        @current_player = @players.first
        true
    end

    def play
        # puts "Welcome!"
        @display.render
        while !@board.over?
            input_truth = @current_player.make_move
            self.rotate_players! if input_truth
            @display.render(@current_player)
        end
        puts "Game over!"
    end

    def rotate_players!
        @players.rotate!
        @current_player = @players.first
    end

end

g = Game.new
g.play