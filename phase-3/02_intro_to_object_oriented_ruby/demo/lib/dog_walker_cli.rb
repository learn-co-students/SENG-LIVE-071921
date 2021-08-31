DOGS = []

def start_cli
  puts "hello! Welcome to the Dog Walker CLI"
  main_menu
  handle_user_choice
  puts "Thanks for using the Dog Walker CLI!"
end

def main_menu
  puts "What would you like to do? Type the number that matches your choice or 'exit' to leave the program".cyan
  print_options
end

def print_options
  puts "Here's a list of the options. Type:".cyan
  puts "  1. To add a dog".cyan
  puts "  2. To list dogs".cyan
  puts "  3. Feed a dog".cyan
  puts "  4. Walk a dog".cyan
  puts "  exit to leave the program".cyan
end

def handle_user_choice
  input = gets.chomp
  while input != "exit"
    if input == "1"
      add_dog.print
    elsif input == "2"
      puts "All Dogs"
      DOGS.each do |dog|
        dog.print
      end
    elsif input == "3"
      feed_dog
    elsif input == "4"
      walk_dog
    elsif input == "debug" 
      binding.pry
    else 
      puts "Whoops! I didn't understand your choice".red
    end
    main_menu
    input = gets.chomp
  end
end

def add_dog
  print "What's your dog's name? ".cyan
  dog_name = gets.chomp
  print "What's your dog's age? ".cyan
  dog_age = gets.chomp
  print "What's your dog's breed? ".cyan
  dog_breed = gets.chomp
  print "What are some of your dog's favorite treats? ".cyan
  favorite_treats = gets.chomp
  dog = Dog.new(dog_name, dog_age, dog_breed, favorite_treats)
  DOGS << dog
  dog
end

def feed_dog
  puts "pick the number matching the dog you'd like to feed" 
  DOGS.each.with_index(1) do |dog, index|
    puts "#{index}. #{dog.name}"
  end
  input = gets.chomp
  input_to_index = input.to_i - 1
  dog_to_feed = DOGS[input_to_index]
  dog_to_feed.feed
  dog_to_feed.print
end

def walk_dog
  puts "pick the number matching the dog you'd like to walk" 
  DOGS.each.with_index(1) do |dog, index|
    puts "#{index}. #{dog.name}"
  end
  input = gets.chomp
  input_to_index = input.to_i - 1
  dog_to_walk = DOGS[input_to_index]
  dog_to_walk.walk
  dog_to_walk.print
end