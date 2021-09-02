class Dog 
  @@all = []

  def self.all
    @@all
  end

  def self.create(attributes)
    self.new(attributes).save
  end

  def self.needs_feeding
    self.all.filter do |dog|
      dog.needs_a_meal?
    end
  end

  def self.needs_walking
    self.all.filter do |dog|
      dog.needs_a_walk?
    end
  end

  attr_accessor :name, :age, :breed, :favorite_treats, :last_walked_at, :last_fed_at
  def initialize(name:, age:, breed:, favorite_treats:)
    @name = name
    @age = age
    @breed = breed
    @favorite_treats = favorite_treats
  end

  def save
    @@all << self
    self
  end

  def walk
    @last_walked_at = DateTime.now
  end

  def feed
    @last_fed_at = DateTime.now
  end

  def needs_a_walk?
    if @last_walked_at
      @last_walked_at < 10.seconds.ago
    else
      true
    end
  end

  def needs_a_meal?
    if @last_fed_at
      @last_fed_at < 15.seconds.ago
    else
      true
    end
  end

  def print
    puts ""
    puts self.name.light_green
    puts "  age: #{self.age}"
    puts "  breed: #{self.breed}"
    puts "  favorite_treats: #{self.favorite_treats}"
    puts "  restless: #{self.needs_a_walk?}"
    puts "  hungry: #{self.needs_a_meal?}"
    puts ""
  end

end

Dog.create(name: "Lennon", age: "1 year", breed: "Pomeranian", favorite_treats: "cheese")
Dog.create(name: "Memphis", age: "2 years", breed: "Greyhound", favorite_treats: "bacon")