require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../neoapi'

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
  
  def test_it_can_pull_api_data
    date = "2019-03-30"
    neoapi = Neoapi.new(date)
    assert_instance_of Faraday::Connection, neoapi.neo_raw_data
  end

  def test_it_can_parse_asteroid_data
    date = "2019-03-30"
    neoapi = Neoapi.new(date)
    assert_instance_of Array, neoapi.asteroid_data
    asteroid_keys = [:links, 
                     :id, 
                     :neo_reference_id, 
                     :name, 
                     :nasa_jpl_url, 
                     :absolute_magnitude_h, 
                     :estimated_diameter, 
                     :is_potentially_hazardous_asteroid, 
                     :close_approach_data, 
                     :is_sentry_object]
    assert_equal neoapi.asteroid_data.first.keys, asteroid_keys
  end
end