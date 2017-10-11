require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================
    
    @key = "433c9d8855eb539384b8fd3f59abcf9e"
    
    def create_url
      url = "https://api.darksky.net/forecast/#{@key}/#{@lat},#{@lng}"
      return url
    end
    
    parsed_data = JSON.parse(open(create_url).read)
    
    current = parsed_data.dig("currently")
     
    @current_temperature = current["temperature"]

    @current_summary = current["summary"]

    #============================next hour======================================

    hour = parsed_data.dig("minutely")
    
    @summary_of_next_sixty_minutes = hour["summary"]
    
    #============================sev hours======================================

    sev_hours = parsed_data.dig("hourly")
    
    @summary_of_next_several_hours = sev_hours["summary"]
  
    #============================sev days=======================================

    sev_days = parsed_data.dig("daily")
    @summary_of_next_several_days = sev_days["summary"]

    render("forecast/coords_to_weather.html.erb")
  end
end
