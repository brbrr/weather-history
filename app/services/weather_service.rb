class WeatherService < ApplicationService
  attr_reader :observation, :response

  def executing
    current_weather && create_observation
  end

  def current_weather
    @response = Faraday.get do |req|
      req.url 'http://api.openweathermap.org/data/2.5/weather'
      req.params['q'] = ENV[DEFAULT_CITY]
      req.params['appid'] = ENV[WEATHER_API]
      req.params['units'] = 'metric'
    end
    @response.success?
  end

  def create_observation
    @observation = Observation.create(observation_params)
    Rails.logger.info "Observation created with: #{observation_params}"

    @observation.persisted?
  end

  private

  def observation_params
    hsh = Oj.load @response.body
    main = hsh[:main]
    {
      temperature: main[:temp],
      pressure: main[:pressure],
      humidity: main[:humidity],
      json: hsh
    }
  end
end
