require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/neoapi'

class NeoapiTest < Minitest::Test
  def test_it_exists
    api_pull = Neoapi.new
    assert_instance_of Neoapi, api_pull
  end
end