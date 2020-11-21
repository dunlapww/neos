require 'minitest/autorun'
require './table'
require './asteroid'

class TableTest < Minitest::Test

  def setup
    @asteroid_data = [
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
        :is_sentry_object=>false},
      {:links=>{:self=>"http://www.neowsapp.com/rest/v1/neo/3562320?api_key=yZaX1lTPU14xNTXRHjHUnjp6pHbI8JhRgJ2njwRQ"},
        :id=>"3562320",
        :neo_reference_id=>"3562320",
        :name=>"(2011 GK44)",
        :nasa_jpl_url=>"http://ssd.jpl.nasa.gov/sbdb.cgi?sstr=3562320",
        :absolute_magnitude_h=>25.6,
        :estimated_diameter=>
        {:kilometers=>{:estimated_diameter_min=>0.0201629919, :estimated_diameter_max=>0.0450858206},
          :meters=>{:estimated_diameter_min=>20.1629919443, :estimated_diameter_max=>45.0858206172},
          :miles=>{:estimated_diameter_min=>0.0125286985, :estimated_diameter_max=>0.0280150214},
          :feet=>{:estimated_diameter_min=>66.1515504905, :estimated_diameter_max=>147.9193637137}},
        :is_potentially_hazardous_asteroid=>false,
        :close_approach_data=>
        [{:close_approach_date=>"2019-03-30",
          :close_approach_date_full=>"2019-Mar-30 13:43",
          :epoch_date_close_approach=>1553953380000,
          :relative_velocity=>{:kilometers_per_second=>"8.3746363008", :kilometers_per_hour=>"30148.6906829514", :miles_per_hour=>"18733.2239413039"},
          :miss_distance=>{:astronomical=>"0.1151239376", :lunar=>"44.7832117264", :kilometers=>"17222295.850972912", :miles=>"10701438.4095017056"},
          :orbiting_body=>"Earth"}],
        :is_sentry_object=>false}
      ]

      @asteroid_list = Asteroid.list(@asteroid_data)
      @column_labels = { name: "Name", diameter: "Diameter", miss_distance: "Missed The Earth By:" }
  end
  
  def test_it_exists
    table = Table.new({},[])
    assert_instance_of Table, table
  end

  def test_it_has_attributes
    table = Table.new(@column_labels, @asteroid_list)
    assert_equal @column_labels, table.column_labels
    assert_equal @asteroid_list, table.row_data
  end
  
  def test_it_can_create_column_data
    table = Table.new(@column_labels, @asteroid_list)
    result = {:name=>{:label=>"Name", :width=>11}, :diameter=>{:label=>"Diameter", :width=>8}, :miss_distance=>{:label=>"Missed The Earth By:", :width=>20}}
    assert_equal result, table.column_data
  end
  
  def test_it_can_create_a_header
    table = Table.new(@column_labels, @asteroid_list)
    result =  "| Name        | Diameter | Missed The Earth By: |"
    assert_equal result, table.header
  end
  
  def test_it_can_create_a_divider
    table = Table.new(@column_labels, @asteroid_list)
    result = "+-------------+----------+----------------------+"
    assert_equal result, table.divider
  end
  
  def test_it_can_create_rows
    table = Table.new(@column_labels, @asteroid_list)
    result = ["| (2011 GE3)  | 123 ft   | 35542652 miles       |\n", "| (2011 GK44) | 147 ft   | 10701438 miles       |\n"]
    assert_equal result, table.create_rows
  end
end