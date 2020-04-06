class SightingsController < ApplicationController

    def index
        sightings = Sighting.all 
        if sightings
            render json: sightings, include: [:bird, :location]
        else 
            render json: {message: 'No sightings found...'}
        end 
    end 

    def show 
        sighting = Sighting.find_by(id: params[:id])
        if sighting 
            render json: sighting, include: [:bird, :location]
        else
            render json: {message: 'Sighting not found...'}
        end 
    end 
end
