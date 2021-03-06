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
the_house = Player.new "Bot 3000", [], 10000, 0

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
        puts "\nShuffling🌪 "
        # clearing all the cards and setting the score/value to 0 each
        human.hand.clear
        human.total = 0 #=> do an or statment here to let them choose?
        the_house.hand.clear
        the_house.total = 0

        puts "#{human.name.blue}, here are your cards:"
        # creating a new empty deck based off of the Deck class
        deck = Deck.new
        # deal 2 cards to the human
        deck.deal_cards(2, human)
        puts "The #{human.hand[0].face} of #{human.hand[0].suit}"
        puts "The #{human.hand[1].face} of #{human.hand[1].suit}"
        
        # deal 2 cards to the house
        deck.deal_cards(2, the_house)
        puts "\n\nThe #{the_house.name.red} would graciously like to show you one card:"
        puts "The #{the_house.hand[0].face} of #{the_house.hand[0].suit}\n\n"

        until human.total >= 21 do
            puts "Would you like to (s)tay or (h)it?"
            hit = gets.chomp.downcase
                if hit == 'h'
                    deck.deal_cards(1, human)
                    puts "#{human.name.blue}, your new card is:"
                    puts "The #{human.hand[0].face} of #{human.hand[0].suit}\n\n"

                    puts "The total value in your hand is:"
				    puts "#{human.total}"
				    puts "The dealer has one card showing:"
                    puts "The #{the_house.hand[0].face} of #{the_house.hand[0].suit}"
                else
                    break
                end
            end

            puts "\n\n#{human.name.blue}, your hand has a total value of #{human.total}"
            puts "The #{the_house.name.red} has a hand value of #{the_house.total}\n"
            
        # TODO figure out win/lose  and stop the loop
        if human.total <= 21 && the_house.total <=21
            if human.total > the_house.total
                puts "#{human.name.blue}, you win!"
                # giving 10 to the human by taking 10 away from house
                human.bankroll += 10
                the_house.bankroll -= 10

            elsif human.total < the_house.total
                puts "The #{the_house.name.red} wins!"
                human.bankroll -= 10
                the_house.bankroll += 10

            else 
                puts "Its a tie" # TODO are there rules for a tie?
                human.bankroll -= 10
                the_house.bankroll += 10
            end 

        elsif human.total > 21 && the_house.total <= 21
            puts "\n\n#{human.name.blue}, you have gone over 21 and lose this round."
            # the house gains as the user/human went over
            human.bankroll -= 10
            the_house.bankroll += 10
            
        elsif human.total <= 21 && the_house.total > 21
            puts "#{the_house.name.red} went over 21. #{human.name.blue}, you win this round."
            # human gains as house went over
            human.bankroll += 10
            the_house.bankroll -= 10

        else human.total > 21 && the_house.total > 21
            puts "#{human.name.blue}, you and #{the_house.name.red} have tied"
            # human.bankroll += 0
            # the_house.bankroll += 0
        end 
        # showing the total of each player
        puts "\n\n#{human.name.blue}, you now have #{human.bankroll}."
        puts "#{the_house.name.red}, now has #{the_house.bankroll}."
        if human.bankroll <= 0
            puts "Wow, #{human.name.blue}, you should stop gambling..."
            break
        else
            puts "#{human.name.blue}, want to play again?\n"
        end
    end 
end

 

        # TODO let player check bankroll at anytime
        # TODO let player bet a different number