require 'open-uri'

class GeocodingController < ApplicationController
  def street_to_coords_form
    # Nothing to do here.
    render("geocoding/street_to_coords_form.html.erb")
  end

  def street_to_coords
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    @a ="AIzaSyDwRwOHVpUPaooZCqs-MgWiEVcXFzjyQLw"
   
    def create_addy
      @street_address.gsub("+", "")
    end
    
    def create_url
       url = "https://maps.googleapis.com/maps/api/geocode/json?address=
       #{create_addy}&key=#{@a}"
       return url
    end
    
    parsed_data = JSON.parse(open(create_url).read)
    
    @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    
    @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    render("geocoding/street_to_coords.html.erb")
  end
end
