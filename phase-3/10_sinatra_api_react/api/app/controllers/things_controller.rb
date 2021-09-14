class ThingsController < ApplicationController
  get "/things" do 
    serialize(Thing.all)
  end

  post "/things" do 
    serialize(Thing.create(thing_params))
  end

  delete "/things/:id" do 
    serialize(Thing.find(params[:id]).destroy)
  end

  private

  def thing_params
    allowed_params = %w(name spot_name category)
    params.select { |param, value| allowed_params.include?(param)}
  end

  def serialize(objects)
    objects.to_json(
      methods: [:spot_name]
    )
  end
end