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
