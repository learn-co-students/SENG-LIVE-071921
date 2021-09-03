class Dog 
  @@all = nil

  def self.all
    rows = DB.execute("SELECT * FROM dogs")
    @@all ||= rows.map do |row|
      self.new_from_row(row)
    end
  end

  # this is necessary because rows in sqlite come in as a hash with string keys
  # because they're strings, initialize won't pick them up as matching the 
  # keyword arguments
  def self.new_from_row(row)
    self.new(
      id: row["id"],
      name: row["name"],
      age: row["age"],
      breed: row["breed"],
      favorite_treats: row["favorite_treats"],
      last_walked_at: row["last_walked_at"],
      last_fed_at: row["last_fed_at"]
    )
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
  attr_reader :id
  def initialize(id: nil, name:, age:, breed:, favorite_treats:, last_walked_at: nil, last_fed_at: nil)
    @id = id
    @name = name
    @age = age
    @breed = breed
    @favorite_treats = favorite_treats
    @last_walked_at = last_walked_at
    @last_fed_at = last_fed_at
  end

  def save
    if id
      sql = <<-SQL
      UPDATE dogs
      SET name = ?, age = ?, breed = ?,favorite_treats = ?, last_walked_at = ?, last_fed_at = ?
      WHERE id = #{id}
      SQL
      DB.execute(sql, name, age, breed, favorite_treats, last_walked_at, last_fed_at)
    else
      sql = <<-SQL
      INSERT INTO dogs (name, age, breed, favorite_treats, last_walked_at, last_fed_at) 
      VALUES (?, ?, ?, ?, ?, ?)
      SQL
      DB.execute(sql, self.name, self.age, self.breed, self.favorite_treats, self.last_walked_at, self.last_fed_at)
      inserted = DB.execute("SELECT * FROM dogs WHERE id = last_insert_rowid()").first
      @id = inserted["id"]
      self.class.all << self
    end
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

# Dog.create(name: "Lennon", age: "1 year", breed: "Pomeranian", favorite_treats: "cheese")
# Dog.create(name: "Memphis", age: "2 years", breed: "Greyhound", favorite_treats: "bacon")