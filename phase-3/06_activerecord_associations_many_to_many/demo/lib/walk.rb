class Walk < ActiveRecord::Base
  has_many :dog_walks
  has_many :dogs, through: :dog_walks

  def self.recent
    self.where("time > ?", 6.hours.ago)
  end
  #equivalent to
  # scope :recent, -> { where("time > ?", 6.hours.ago)}

  def print
    puts ""
    puts self.formatted_time.light_green
    puts "Dogs:"
    self.dogs.each do |dog|
      puts "  #{dog.name}"
    end
    puts ""
  end

  def formatted_time
    time.strftime('%A, %m/%d %l:%M %p')
  end
end