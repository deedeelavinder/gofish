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

  def print_hand
    # puts "hand for #@name:"
    # puts "  hand: "+ @hand.values.flatten.sort.join(', ')
    # puts "  books: "+ @books.join(', ')
  end

end
