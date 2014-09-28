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
