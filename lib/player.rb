require 'rubycards'
include RubyCards

class Player
  attr_accessor :name, :player_hand,

  def initialize(name, player_hand)
    @name = name
    @player_hand = player_hand
  end

  def deal_player
    @player_hand = Hand.new
  end

  def player_name
    print ""
end
# player1 = Player.new
# player1.deal_player
