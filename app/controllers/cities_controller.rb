class CitiesController < ApplicationController
  
   def show 
   @city = City.find(params[:id])
   @gossip = Gossip.all
  end
  
end