DOGS = []

def start_cli
  puts "hello! Welcome to the Dog Walker CLI"
  main_menu
  handle_user_choice
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
  puts "  7. To view all walks for a particular dog".cyan
  puts "  8. To view all feedings for a particular dog".cyan
  puts "  exit to leave the program".cyan
end

def handle_user_choice
  input = ask_for_input
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
    elsif input == "7"
      list_walks_for_dog
    elsif input == "8"
      list_feedings_for_dog
    elsif input == "debug" 
      binding.pry
    else 
      puts "Whoops! I didn't understand your choice".red
    end
    main_menu
    input = ask_for_input
  end
end

def add_dog
  print "What's your dog's name? ".cyan
  name = ask_for_input
  print "What's your dog's age? ".cyan
  age = ask_for_input
  print "What's your dog's breed? ".cyan
  breed = ask_for_input
  print "What are some of your dog's favorite treats? ".cyan
  favorite_treats = ask_for_input
  dog = Dog.create(
    name: name, 
    age: age, 
    breed: breed, 
    favorite_treats: favorite_treats
  )
end

def feed_dog
  puts "pick the number matching the dog you'd like to feed" 
  dog = prompt_user_to_choose_dog
  dog.feed
  dog.print
end

def walk_dog
  puts "pick the number matching the dog you'd like to walk" 
  dog = prompt_user_to_choose_dog
  dog.walk
  dog.print
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

def list_walks_for_dog
  puts "Which dog do you want to view past walks for?"
  dog = prompt_user_to_choose_dog
  puts "Recent walks for #{dog.name}:"
  dog.walks.order(time: :desc).each do |walk|
    puts "time: #{walk.time.strftime('%A, %m/%d %l:%M %p')}"
  end
end

def list_feedings_for_dog
  puts "Which dog do you want to view past feedings for?"
  dog = prompt_user_to_choose_dog
  puts "Recent feedings for #{dog.name}:"
  dog.feedings.order(time: :desc).each do |walk|
    puts "time: #{walk.time.strftime('%A, %m/%d %l:%M %p')}"
  end
end

def prompt_user_to_choose_dog
  Dog.all.each.with_index(1) do |dog, index|
    puts "#{index}. #{dog.name}"
  end
  input = ask_for_input
  input_to_index = input.to_i - 1
  if input_to_index < 0
    puts "Hmm... I didn't understand that choice!".red
    puts
    puts "Please choose a number that matches the dog you'd like to choose".
    prompt_user_to_choose_dog
  else
    Dog.all[input_to_index]
  end
end

def ask_for_input
  input = gets.chomp
  if input == "exit" 
    puts "Thank you for using the appointments CLI."
    exit
  end
  input
end