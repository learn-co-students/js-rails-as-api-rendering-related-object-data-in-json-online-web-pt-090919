class SightingsController < ApplicationController  
  def index
    sightings = Sighting.all
    # add error handling
    if sighting
      # rails obscuring `.to_json()` after `sightings`
      # render json: sightings, include: [:bird, :location]
      render json: sighting.to_json(include: [:bird, :location])
    else
      render json: { message: 'No sighting found with that id' }
    end
  end  
  
  def show
    sighting = Sighting.find_by(id: params[:id])
    # render json: sighting
    # Include bird and location information in this controller action
    # - using custom hash
    # render json: { id: sighting.id, bird: sighting.bird, location: sighting.location }
    # - using include
      # all attributes of included objects will be listed by default
      # remove the `:updated_at` attribute from `Sighting` when rendered:
    # render json: sighting, include: [:bird, :location], except: [:updated_at]
    # add nesting into the options - included bird & location data can have their own options listed
    render json: sighting.to_json(:include => {
      :bird => {:only => [:name, :species]},
      :location => {:only => [:latitude, :longitude]}
    }, :except => [:updated_at])
  end
end
