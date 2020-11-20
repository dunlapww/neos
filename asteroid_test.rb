require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative 'asteroid'

class AsteroidTest < Minitest::Test
  def test_it_exists
    asteroid_details = Hash.new
    asteroid_details[:name] = "Larry"
    asteroid_details[:diameter] = 10
    asteroid_details[:miss_distance] = 30
    asteroid = Asteroid.new(asteroid_details)
    assert_instance_of Asteroid, asteroid
  end
end