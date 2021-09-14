class SpotsController < ApplicationController
  get "/spots" do 

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
    
  end
end