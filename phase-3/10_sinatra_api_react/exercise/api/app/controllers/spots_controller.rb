class SpotsController < ApplicationController
  get "/spots" do 
    serialize(Spot.all)
  end

  post "/spots" do 

  end

  delete "/spots/:id" do 

  end

  private

  def spot_params
    allowed_params = %w(name)
    params.select { |param, value| allowed_params.include?(param)}
  end

  def serialize(objects)
    # you may not need to adjust this at all for the moment, but it's here in case you want to later
    objects.to_json
  end
end