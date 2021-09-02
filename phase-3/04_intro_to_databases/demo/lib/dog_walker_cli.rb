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
  puts "  3. To feed a dog".cyan
  puts "  4. To walk a dog".cyan
  puts "  5. To list dogs who need feeding".cyan
  puts "  6. To list dogs who need walking".cyan
  puts "  exit to leave the program".cyan
end

def handle_user_choice
  input = gets.chomp
  while input != "exit"
    if input == "1"
      add_dog.print
    elsif input == "2"
      puts "All Dogs"
      Dog.all.each do |dog|
        dog.print
      end
    elsif input == "3"
      feed_dog
    elsif input == "4"
      walk_dog
    elsif input == "5"
      list_dogs_who_need_feeding
    elsif input == "6"
      list_dogs_who_need_walking
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
  name = gets.chomp
  print "What's your dog's age? ".cyan
  age = gets.chomp
  print "What's your dog's breed? ".cyan
  breed = gets.chomp
  print "What are some of your dog's favorite treats? ".cyan
  favorite_treats = gets.chomp
  dog = Dog.create(
    name: name, 
    age: age, 
    breed: breed, 
    favorite_treats: favorite_treats
  )
end

def feed_dog
  puts "pick the number matching the dog you'd like to feed" 
  Dog.all.each.with_index(1) do |dog, index|
    puts "#{index}. #{dog.name}"
  end
  input = gets.chomp
  input_to_index = input.to_i - 1
  dog_to_feed = Dog.all[input_to_index]
  dog_to_feed.feed
  dog_to_feed.print
end

def walk_dog
  puts "pick the number matching the dog you'd like to walk" 
  Dog.all.each.with_index(1) do |dog, index|
    puts "#{index}. #{dog.name}"
  end
  input = gets.chomp
  input_to_index = input.to_i - 1
  dog_to_walk = Dog.all[input_to_index]
  dog_to_walk.walk
  dog_to_walk.print
end

def list_dogs_who_need_feeding
  puts "Dogs who need feeding:".light_green
  dogs = Dog.needs_feeding
  dogs.each do |dog|
    dog.print
  end
  if dogs.empty?
    puts "All dogs are fed!"
  end
end

def list_dogs_who_need_walking
  puts "Dogs who need walking:".light_green
  dogs = Dog.needs_walking
  dogs.each do |dog|
    dog.print
  end
  if dogs.empty?
    puts "All dogs are walked!"
  end
end