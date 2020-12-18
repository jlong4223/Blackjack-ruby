# gem installs colorize and requires
require 'colorize'

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

# p human
# p the_house


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

# getting the name from a prompt
def prompt_greeting(namehere)
    print(namehere)
    gets
end 

# using .chomp to get rid of default space(\n) after the inputed name
name = prompt_greeting("\nHello player, what is your name? ").chomp
puts "\n\nHi there #{name.blue}, ready for some black jack?"

# setting the player to be the name given with the prompt
human.name="#{name}"
    # uncomment next line to check if name was assigned to the player class
# p human

loop do
    puts "(D)eal the cards, or (N)o not right now"
    # gets the user input, removes space, & sets it to lowercase
    lets_play = gets.chomp.downcase
    if lets_play == "n"
        puts "Bye #{name.red}, you didn't seem skilled enough anyway..."
        break
    else 
        puts "Lets play a game"
        # clearing all the cards and setting the score/value to 0 each
        human.hand.clear
        human.total = 0 #=> do an or statment here to let them choose?
        the_house.hand.clear
        the_house.total = 0

        puts "Here are your cards:"
        # creating a new empty deck based off of the Deck class
        deck = Deck.new
        # deal 2 cards to the human
        deck.deal_cards(2, human)
        puts "The #{human.hand[0].face} of #{human.hand[0].suit}"
        puts "The #{human.hand[1].face} of #{human.hand[1].suit}"
        
        # deal 2 cards to the house
        deck.deal_cards(2, the_house)
        puts "\n\nThe house would graciously like to show you one card:"
        puts "The #{the_house.hand[0].face} of #{the_house.hand[0].suit}"

    end
end 