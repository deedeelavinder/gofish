require 'card'

class Deck
  attr_reader :deck

  def initialize
    @deck = []
    Card::SUITS.each do |suit|
      Card::RANKS.each do |rank|
        @deck << Card.new(rank, suit)
      end
    end
    @deck.shuffle!
  end

  def deal(n=1)
    @deck.pop(n)
  end

  def empty?
    @deck.empty?
  end

  def cards_remaining
    @deck.length
  end
end
