require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/neoapi'

class NeoapiTest < Minitest::Test
  def test_it_exists
    date = "2019-03-30"
    api_pull = Neoapi.new(date)
    assert_instance_of Neoapi, api_pull
  end
  
  def test_it_has_date
    date = "2019-03-30"
    neoapi = Neoapi.new(date)
    assert_equal("2019-03-30", neoapi.date)
  end
end