class Dealer < Players

  def initialize(game)
    super
    @name = "Bob"
  end

  def wanted_card
    puts "If you have what I need, I'll go ahead and take it."
    known = @hand.keys & @other_players_hand[:has_asked_for]
    if known.empty?
      possibilities = @hand.keys - @other_players_hand[:has_not_asked_for]
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
