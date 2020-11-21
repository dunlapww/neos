require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative 'asteroid_view'

class AsteroidViewTest < Minitest::Test

  def test_it_exists
    view = AsteroidView.new
    assert_instance_of AsteroidView, view
  end
end