require "minitest/autorun"
require "game"
require "player"

class GameTest < Minitest::Test
  def test_first_test
    assert true, "Please add a test here"
  end
  def test_that_we_have_a_player
    assert true, Player.new
  end
end
