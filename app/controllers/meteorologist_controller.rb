require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    @a ="AIzaSyDwRwOHVpUPaooZCqs-MgWiEVcXFzjyQLw"
    @key = "433c9d8855eb539384b8fd3f59abcf9e"

    def geocode_url
       conc_addy = @street_address.gsub("+", "")
       url = "https://maps.googleapis.com/maps/api/geocode/json?address=
       #{conc_addy}&key=#{@a}"
       parsed_data = JSON.parse(open(url).read)
      return parsed_data
    end
  
    def lat
      latitude = geocode_url["results"][0]["geometry"]["location"]["lat"]
      return latitude
    end
    
    def long 
      longitude = geocode_url["results"][0]["geometry"]["location"]["lng"]
      return longitude
    end
    
    def forecast_url
      url = "https://api.darksky.net/forecast/#{@key}/#{lat},#{long}"
      parsed_data_forecast = JSON.parse(open(url).read)
      return parsed_data_forecast
    end
    
    current = forecast_url.dig("currently")
     
    @current_temperature = current["temperature"]

    @current_summary = current["summary"]

    #============================next hour======================================

    hour = forecast_url.dig("minutely")
    
    @summary_of_next_sixty_minutes = hour["summary"]
    
    #============================sev hours======================================

    sev_hours = forecast_url.dig("hourly")
    
    @summary_of_next_several_hours = sev_hours["summary"]
  
    #============================sev days=======================================

    sev_days = forecast_url.dig("daily")
    @summary_of_next_several_days = sev_days["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
