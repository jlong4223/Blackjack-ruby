# The Players =========================================
# sets up a class blueprint for the players
class Player 
    attr_accessor :name, :hand, :bankroll
    def initialize name, hand, bankroll, :total
        @name = name
        @hand = []
        @bankroll = bankroll
        @total = total
    end
end

# creates the two player classes 
human = Player.new "Human", [], 100
the_house = Player.new "Computer", [], 10000

p human
p the_house


# The Deck ===========================================

# empty array to hold cards object
cards = []
class Card
    attr_accessor :face, :suit, :value
    def initialize face, suit, value
        @face = face
        @suit = suit 
        @value = value
    end
end

class Deck
    def initialize
        @faces = [*(2..10), 'Jack', 'Queen', 'King', 'Ace']
        @suits = ['clubs', 'spades', 'hearts', 'diamonds']
        @cards = []
    end
end 