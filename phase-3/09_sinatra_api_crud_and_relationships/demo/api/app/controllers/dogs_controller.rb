class DogsController < ApplicationController
  
  get "/dogs" do 
    serialize(Dog.all)
  end

  get "/dogs/:id" do 
    dog = Dog.find(params[:id])
    serialize(dog)
  end

  post "/dogs" do 
    serialize(Dog.create(dog_params))
  end

  patch "/dogs/:id" do
    dog = Dog.find(params[:id])
    dog.update(dog_params)
    serialize(dog)
  end

  delete "/dogs/:id" do 
    dog = Dog.find(params[:id])
    dog.destroy
    serialize(dog)
  end

  private 

  # a method used to specify which keys are allowed through params into the controller
  # we use this method to create a list of what's permitted to be passed to .create or .update
  # within controller actions.
  def dog_params
    allowed_params = %w(name birthdate breed image_url)
    params.select {|param,value| allowed_params.include?(param)}
  end

  def serialize(dog)
    dog.to_json(
      methods: :age
    )
  end
end