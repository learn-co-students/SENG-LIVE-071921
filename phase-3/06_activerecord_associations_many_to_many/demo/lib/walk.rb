class Walk < ActiveRecord::Base
  belongs_to :dog

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