class ThingsController < ApplicationController
  get "/things" do 

  end

  post "/things" do 

  end

  delete "/things/:id" do 

  end

  private

  def thing_params
    allowed_params = %w(name spot_name category)
    params.select { |param, value| allowed_params.include?(param)}
  end

  def serialize(objects)
    
  end
end