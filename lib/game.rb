# require_relative 'players'
# require_relative 'dealer'
# require_relative 'player'
# require_relative 'card'
# require_relative 'deck'

class Game
  attr_accessor :hand, :deck

  def initialize
    @deck = Deck.new
    @players = []
    @players << Player.new
    @players << Dealer.new(self)
    @players.each {|p| deal(p, 7)}
    p @players
  end

  def greeting(player)
    print "Let's play 'Go, Fish!', #{@player}."
    start
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
    puts "Game over"
    @players.each {|p| puts "#{p.name} has #{p.num_books} books."}
    nil
  end

  def switch_turns
    @players.push(@players.shift)
  end
end

class Players
  attr_reader :name

  def initialize(game)
    @game = game
    @hand = {}
    @books = []
    @other_players_hand = {:has_asked_for => [], :has_not_asked_for => []}
  end

  def ask(other_players)
    wanted = wanted_card
    puts "#{@name}: Do you have a #{wanted}?"
    received = other_players.answer(wanted)
    @other_players_hand[:has_asked_for].delete(wanted)
    if received.empty?
      @game.deal(self, 1)
      @other_players_hand[:has_not_asked_for] = []
      false
    else
      take_cards(received)
      @other_players_hand[:has_not_asked_for].push(wanted).uniq!
      true
    end
  end

  def answer(rank)
    cards = []
    @other_players_hand[:has_asked_for].push(rank).uniq!
    if @hand[rank]
      cards = @hand[rank]
      @hand.delete(rank)
      puts "#{@name}: Why, yes I do. Here you go -- #{cards.join(', ')}."
      @game.deal(self, 1) if @hand.empty?
    else
      puts "#@name: Go Fish!"
    end
    cards
  end

  def take_cards(card_s)
    my_cards = @hand.values.flatten(card_s)
    @hand = my_cards.group_by {|card| card.rank}

    @hand.each do |rank, cards|
      if cards.length == 4
        puts "#{@name} made a book of #{rank}."
        @books << rank
        @hand.delete(rank)
      end
    end
    if @hand.empty? && @game.deck != empty?
      @game.deal(self, 1)
    end
  end

  def num_books
    @books.length
  end
  #
  # def print_hand
  #   puts "hand for #@name:"
  #   puts "  hand: "+ @hand.values.flatten.sort.join(', ')
  #   puts "  books: "+ @books.join(', ')
  #   puts "opponent is known to have: " + @opponents_hand[:has_asked_for].sort.join(', ')
  # end

end

class Dealer < Players

  def initialize(game)
    super
    @name = "Bob"
  end

  def wanted_card
    known = @hand.keys & @other_players_hand[:known_to_have]
    if known.empty?
      possibilities = @hand.keys - @other_players_hand[:known_not_to_have]
      if possibilities.empty?
        the_most_of(@hand.keys).first
        @hand.keys.shuffle.first
      else
        possibilities.shuffle.first
      end
    else
      the_most_of(known).first
    end
  end

  def the_most_of(best_rank)
    best_rank.sort_by {|rank| -@hand[rank].length}
  end
end

class Player < Players
  attr_accessor :name, :player_hand,

  def initialize(game)
    super
    @name = "Alice"
    # get_name
  end

  # def get_name
  #   print "Hi there. My name is Bob. What is your name?"
  #   @name = gets.chomp
  # end

  def take_cards(cards)
    puts "#{@name}, here you are: #{cards.join(', ')}"
    super
  end

  def wanted_card
    print_hand
    wanted = nil
    loop do
      print "\n#{@name}, What would you like to ask for?"
      wanted = gets.strip!.upcase!
      until Card::RANKS.include?(wanted)
        puts "Whoops, that is not a valid rank: #{wanted} -- try again."
      end
      until @hand.has_key?(wanted)
        puts "Whoops, you don't have a #{wanted} -- try again."
      end
    end
    wanted
  end

end

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

class Card
  attr_reader :rank, :suit

  RANKS = %w(2 3 4 5 6 7 8 9 10 J Q K A)
  SUITS = %w(S H C D)

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    @rank + @suit
  end
end

Game.new.start
