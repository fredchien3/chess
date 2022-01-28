class HumanPlayer
    attr_reader :name, :color
    def initialize(name, color, display)
        @name = name
        @color = color
        @display = display
        @cursor = @display.cursor
    end

    def make_move
        begin
        input_truth = @cursor.get_input(@color) # if true, move was made. else, don't continue
        rescue => e
            puts "#{e}"
            retry
        end
        @display.render(self)
        return input_truth if input_truth
    end
end