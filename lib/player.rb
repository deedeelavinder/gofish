class Player < Players
  attr_accessor :name, :player_hand,

  def initialize(game)
    super
    @name = name.get_name
  end

  def get_name
    print "Hi there. My name is Bob. What is your name?"
    @name = gets.chomp
  end

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
