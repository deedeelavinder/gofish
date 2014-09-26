require 'rubycards'
require 'dealer'
require 'player'
include RubyCards

class Game
  def initialize
    # @dealer=Dealer.new
    @player=Player.new
    @deck=Deck.new
  end
#
#   @player=player
#   @player.first_deal
#   dealer=Dealer.new.first_deal
#   dealer=@dealer
#   greeting

  def get_name
    puts "Hi there. My name is Bob. What is your name?"
    @player = gets.chomp
  end
#
#   def greeting(player)
#     player = @player.new
#     print "Let's play 'Go, Fish!', #{@player}."
#   end
#
#   def first_deal
#     dealer_hand.new(deck, 7)
#     player.hand.new(deck, 7)
#   end
#
#
#   def show_hand(hand)
#     hand = @hand
#     puts @hand
#   end
#
#   def ask_for_players_card
#     puts "#{player}, do you have a #{card}?"
#   end
#
#   def players_choice(card)
#     puts "Please choose which card you would like to ask for."
#     puts player_hand
#     card = gets.chomp.to_s
#     card = @card
#   end
#
#   def add_to_hand(hand)
#     @hand=hand
#     @hand <= players_choice
#   end
#
#   def lay_books_down
#   end
#
#   def go_fish_draw
#   end
#
#   def whoa_dude
#   end
end
go_fish=Game.new
go_fish.get_name
