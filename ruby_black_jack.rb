# The Players =========================================
# sets up a class blueprint for the players
class Player 
    def initialize name, hand, bankroll
        @name = name
        @hand = []
        @bankroll = bankroll
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

class Card_Objects 

    
end
