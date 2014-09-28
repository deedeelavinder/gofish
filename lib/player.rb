class Player < Players
  attr_accessor :name, :player_hand

  def initialize(game)
    super
    @name = name
    get_name
  end

  def get_name
    print "Hi there. My name is Bob. I'm just a computer, but we can still have fun.\n How about if we play Go, Fish. What is your name?"
    puts
    @name = gets.chomp
  end

  def take_cards(cards)
    puts "Here it is: #{cards.join(', ')}"
    puts
    super
  end

  def wanted_card
    print_hand
    wanted = nil
    loop do
      print "\n#{@name}, What would you like to ask for?"
      puts
      wanted = $stdin.gets
      wanted.strip!.upcase!
      if Card::RANKS.include?(wanted) && @hand.has_key?(wanted)
        break
      else
        puts "Whoops, you must enter a valid rank from your hand. Please try again."
        puts
      end
    end
    wanted
  end
end
