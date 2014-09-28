class Player < Players
  attr_accessor :name, :player_hand

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
      wanted = $stdin.gets
      wanted.strip!.upcase!
      if Card::RANKS.include?(wanted) && @hand.has_key?(wanted)
        break
      else
        puts "Whoops, you must enter a valid rank from your hand. Please try again."
      end
    end
    wanted
  end

end
