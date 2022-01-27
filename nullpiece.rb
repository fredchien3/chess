require_relative 'piece.rb'
require 'singleton'

class Nullpiece < Piece
    include Singleton
    attr_reader :color, :symbol
    def initialize
        @symbol = " "
    end
end