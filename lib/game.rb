require_relative 'players'
require_relative 'dealer'
require_relative 'player'
require_relative 'card'
require_relative 'deck'

class Game
  attr_accessor :hand, :deck

  def initialize
    @deck = Deck.new
    @players = []
    @players << Player.new(self)
    @players << Dealer.new(self)
    @players.each {|p| deal(p, 7)}
  end

  def deal(player, n=1)
    n = [n, @deck.cards_remaining].min
    player.take_cards(@deck.deal(n))
  end

  def start
    loop do
      p1, p2 = @players
      p1.ask(p2) or switch_turns
      break if p1.num_books + p2.num_books == 13
    end
    puts "Game over. Thanks for playing!"
    @players.each {|p| puts "#{p.name} has #{p.num_books} books."}
    nil
  end

  def switch_turns
    @players.push(@players.shift)
  end
end

Game.new.start
