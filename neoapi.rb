require 'faraday'
require 'JSON'
require 'figaro'

Figaro.application = Figaro::Application.new(environment: 'production', path: File.expand_path('../config/application.yml', __FILE__))
Figaro.load

class Neoapi
  attr_reader :date
  
  def initialize(date)
    @date = date
  end

  def neo_raw_data
    Faraday.new(
      url: 'https://api.nasa.gov',
      params: { start_date: @date, api_key: ENV['nasa_api_key']}
    )
  end

  def asteroid_data
    list_data = neo_raw_data.get('/neo/rest/v1/feed')
    output = JSON.parse(list_data.body, symbolize_names: true)[:near_earth_objects][:"#{@date}"]
  end

end