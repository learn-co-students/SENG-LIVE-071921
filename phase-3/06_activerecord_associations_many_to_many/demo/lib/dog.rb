class Dog < ActiveRecord::Base
  has_many :dog_walks, dependent: :destroy
  has_many :walks, through: :dog_walks
  has_many :feedings
  
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

  
  def walk
    now = Time.now
    self.update(last_walked_at: now)
    self.walks.create(time: now)
  end

  def feed
    now = Time.now
    self.update(last_fed_at: now)
    self.feedings.create(time: now)
  end

  def needs_a_walk?
    if self.last_walked_at
      self.last_walked_at < 10.seconds.ago
    else
      true
    end
  end

  def needs_a_meal?
    if self.last_fed_at
      self.last_fed_at < 15.seconds.ago
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

