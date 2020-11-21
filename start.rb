require_relative 'neoapi'
require_relative './lib/asteroid'
require_relative './lib/table'

puts "________________________________________________________________________________________________________________________________"
puts "Welcome to NEO. Here you will find information about how many meteors, astroids, comets pass by the earth every day. \nEnter a date below to get a list of the objects that have passed by the earth on that day."
puts "Please enter a date in the following format YYYY-MM-DD."
print ">>"

date = gets.chomp

api_data = Neoapi.new(date)
asteroid_data = api_data.asteroid_data
asteroid_list = Asteroid.list(asteroid_data)
total_number_of_asteroids = Asteroid.count(asteroid_data)
largest_asteroid = Asteroid.largest(asteroid_data)

column_labels = { name: "Name", diameter: "Diameter", miss_distance: "Missed The Earth By:" }

asteroid_table = Table.new(column_labels, asteroid_list)

formated_date = DateTime.parse(date).strftime("%A %b %d, %Y")

puts "______________________________________________________________________________"
puts "On #{formated_date}, there were #{total_number_of_asteroids} objects that almost collided with the earth."
puts "The largest of these was #{largest_asteroid} ft. in diameter."
puts "\nHere is a list of objects with details:"

print asteroid_table.display_table