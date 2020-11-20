require 'faraday'
require 'figaro'
require 'pry'
# Load ENV vars via Figaro
Figaro.application = Figaro::Application.new(environment: 'production', path: File.expand_path('../config/application.yml', __FILE__))
Figaro.load


#the NEOs class:
  #1. makes a request to the API, and stores the response as 'conn'
  #2. stores part of the reponse in a variable called 'asteroids_list_data'
  #3. converts that response into a symbolized hash and filters on just near earth objects on the date requested
  #4. finds the largest asteroid in the list
  #5. finds the number of asteroids on that day
  #6. formats specific details of each in asteroid into a new hash and stores those hashes in an array called formatted_asteroid_data
  #7. returns a summary of the day's asteroid details in a hash.
  #8. mispells asteroid an astounding number of times.


#Instead of current state, we could:
#1 Have  class called 'NeoData' that gets all API data
  #a.  method: 'neos' - returns parsed_asteroids_data
#2 Have an 'Asteroid' class that stores all data about an asteroid
  #attributes: diameter, name, missed earth by
class NearEarthObjects
  def self.find_neos_by_date(date)
    conn = Faraday.new(
      url: 'https://api.nasa.gov',
      params: { start_date: date, api_key: ENV['nasa_api_key']}
    )
    asteroids_list_data = conn.get('/neo/rest/v1/feed')
    
    parsed_asteroids_data = JSON.parse(asteroids_list_data.body, symbolize_names: true)[:near_earth_objects][:"#{date}"]
    
    largest_astroid_diameter = parsed_asteroids_data.map do |astroid|
      astroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i
    end.max { |a,b| a<=> b}
    
    total_number_of_astroids = parsed_asteroids_data.count
    formatted_asteroid_data = parsed_asteroids_data.map do |astroid|
      {
        name: astroid[:name],
        diameter: "#{astroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i} ft",
        miss_distance: "#{astroid[:close_approach_data][0][:miss_distance][:miles].to_i} miles"
      }
    end
    
    {
      astroid_list: formatted_asteroid_data,
      biggest_astroid: largest_astroid_diameter,
      total_number_of_astroids: total_number_of_astroids
    }
  end
end
