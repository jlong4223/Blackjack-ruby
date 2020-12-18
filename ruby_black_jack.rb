# The Players =========================================
# sets up a class blueprint for the players
class Player 
    attr_accessor :name, :hand, :bankroll, :total
    def initialize name, hand, bankroll, total
        @name = name
        @hand = []
        @bankroll = bankroll
        @total = total
    end
end

# creates the two player classes based on the Class blueprint above
human = Player.new "Human", [], 100, 0
the_house = Player.new "Computer", [], 10000, 0

p human
p the_house


# The Deck ===========================================

# empty array to hold cards object
# cards = []
class Card
    attr_accessor :face, :suit, :value
    def initialize face, suit, value
        @face = face
        @suit = suit 
        @value = value
    end

    def makes_card player
        new_card = Card.new face, suit, value
        player.hand << new_card
        # updating the total number for the player to see
        player.total = player.total + new_card.value
    end 
end

class Deck
    def initialize
        @faces = [*(2..10), 'Jack', 'Queen', 'King', 'Ace']
        @suits = ['clubs', 'spades', 'hearts', 'diamonds']
        @cards = []
        # loopig over the faces array to create cards & values
        @faces.each do |face|
            if face.class == Integer
                # the value is set to = the faces if an integer(2-10)
                value = face # QUESTION can I do self here?
            elsif face == 'Ace'
                value = 11
            else 
                # jack, queen, king value defined here
                value = 10
            end
            # looping through suits
            @suits.each do |suit|
                # pushing cards into a new array that follows the card class template
                @cards << Card.new(face, suit, value)
            end 
        end
        # shuffling cards below
    @cards.shuffle!
    end 

    def deal_cards(num, player)
        # taking the card out of the deck and putting it in the players hand with .shift
        num.times {@cards.shift.makes_card(player)}
    end 
end 


# Time to get started with prompts and gameplay ==============

def prompt_greeting(namehere)
    print(namehere)
    gets
end 

name = prompt_greeting("Hello player, what is your name? ").chomp
p "Hi there #{name}, ready for some black jack?"

# setting the player to be the name given with the prompt
human.name="#{name}"
# uncomment to check if name was assigned to the player class
p human