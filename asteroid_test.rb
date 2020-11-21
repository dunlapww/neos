require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative 'asteroid'

class AsteroidTest < Minitest::Test

  def setup
    @asteroid_data =
      {:links=>{:self=>"http://www.neowsapp.com/rest/v1/neo/3561029?api_key=yZaX1lTPU14xNTXRHjHUnjp6pHbI8JhRgJ2njwRQ"},
        :id=>"3561029",
        :neo_reference_id=>"3561029",
        :name=>"(2011 GE3)",
        :nasa_jpl_url=>"http://ssd.jpl.nasa.gov/sbdb.cgi?sstr=3561029",
        :absolute_magnitude_h=>26.0,
        :estimated_diameter=>
         {:kilometers=>{:estimated_diameter_min=>0.0167708462, :estimated_diameter_max=>0.0375007522},
          :meters=>{:estimated_diameter_min=>16.7708462163, :estimated_diameter_max=>37.5007521798},
          :miles=>{:estimated_diameter_min=>0.0104209175, :estimated_diameter_max=>0.0233018799},
          :feet=>{:estimated_diameter_min=>55.0224631002, :estimated_diameter_max=>123.0339677816}},
        :is_potentially_hazardous_asteroid=>false,
        :close_approach_data=>
         [{:close_approach_date=>"2019-03-30",
           :close_approach_date_full=>"2019-Mar-30 05:04",
           :epoch_date_close_approach=>1553922240000,
           :relative_velocity=>{:kilometers_per_second=>"18.6491093989", :kilometers_per_hour=>"67136.7938360274", :miles_per_hour=>"41716.1928143916"},
           :miss_distance=>{:astronomical=>"0.382360762", :lunar=>"148.738336418", :kilometers=>"57200355.56677694", :miles=>"35542652.814484172"},
           :orbiting_body=>"Earth"}],
        :is_sentry_object=>false}
  end
  def test_it_exists
    asteroid = Asteroid.new(@asteroid_data)
    assert_instance_of Asteroid, asteroid
  end

  def test_it_has_details
    asteroid = Asteroid.new(@asteroid_data)
    assert_equal "(2011 GE3)", asteroid.name 
    assert_equal 123, asteroid.diameter
    assert_equal 35542652, asteroid.miss_distance
  end
end