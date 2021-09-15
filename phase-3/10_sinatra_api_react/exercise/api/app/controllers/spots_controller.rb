class SpotsController < ApplicationController
  get "/spots" do 
    serialize(Spot.all)
  end

  post "/spots" do 
    serialize(Spot.create(spot_params))
  end

  delete "/spots/:id" do 
    serialize(Spot.find(params[:id]).destroy)
  end

  private

  def spot_params
    allowed_params = %w(name)
    params.select { |param, value| allowed_params.include?(param)}
  end

  def serialize(objects)
    objects.to_json
  end
end