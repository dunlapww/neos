class Asteroid
  attr_reader :name, :diameter, :miss_distance

  def initialize(asteroid_details)
    @name = asteroid_details[:name]
    @diameter = asteroid_details[:estimated_diameter][:feet][:estimated_diameter_max].to_i
    @miss_distance = asteroid_details[:close_approach_data][0][:miss_distance][:miles].to_i
  end

  def self.all_asteroids(asteroid_data)
    asteroid_data.map do |asteroid_details|
      Asteroid.new(asteroid_details)
    end
  end

  def self.count(asteroid_data)
    all_asteroids(asteroid_data).size
  end

  def self.largest(asteroid_data)
    all_asteroids(asteroid_data).max_by{|asteroid| asteroid.diameter}
  end

  def self.list(asteroid_data)
    list =  []
    all_asteroids(asteroid_data).each do |asteroid|
      ast_hash = Hash.new
      ast_hash[:name]=asteroid.name
      ast_hash[:diameter]=asteroid.diameter.to_s + " ft"
      ast_hash[:miss_distance] = asteroid.miss_distance.to_s + " miles"
      list << ast_hash
    end
    list
  end

end