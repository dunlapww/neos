class Asteroid
  attr_reader :name, :diameter, :miss_distance

  def initialize(asteroid_details)
    @name = asteroid_details[:name]
    @diameter = asteroid_details[:estimated_diameter][:feet][:estimated_diameter_max].to_i
    @miss_distance = asteroid_details[:close_approach_data][0][:miss_distance][:miles].to_i
  end

end