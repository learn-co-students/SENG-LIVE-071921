PROMPT = TTY::Prompt.new(interrupt: :exit)
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
  puts "  2. To view Dog Info".cyan
  puts "  3. To add a walk".cyan
  puts "  4. To view Walk info".cyan
  puts "  exit to leave the program".cyan
end

def handle_user_choice
  input = ask_for_input
  while input != "exit"
    if input == "1"
      add_dog.print
    elsif input == "2"
      dog_info
    elsif input == "3"
      create_walk
    elsif input == "4"
      walk_info
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

def dog_info
  list_dogs
  print_dog_interaction_choices
  input = ask_for_input
  until input == "back"
    if input == "1" 
      feed_dog
    elsif input == "2"
      walk_dog
    elsif input == "3"
      list_dogs_who_need_feeding
    elsif input == "4"
      list_dogs_who_need_walking
    elsif input == "5"
      list_walks_for_dog
    elsif input == "6"
      list_feedings_for_dog
    else
      puts "Whoops! I didn't understand your choice".red
    end
    print_dog_interaction_choices
    input = ask_for_input
  end
end

def list_dogs
  puts "Dogs: "
  Dog.all.each do |dog|
    puts dog.name
  end
end

def print_dog_interaction_choices
  puts "Dogs Submenu: What would you like to do?"
  puts "  1. To feed a dog".cyan
  puts "  2. To walk a dog".cyan
  puts "  3. To view all dogs who need feeding".cyan
  puts "  4. To view all dogs who need walking".cyan
  puts "  5. To view all walks for a particular dog".cyan
  puts "  6. To view all feedings for a particular dog".cyan
  puts "  back to return to the main menu".cyan
  puts "  exit to leave the program".cyan
end

def feed_dog
  puts "pick the number matching the dog you'd like to feed" 
  dog = prompt_user_to_choose_dog
  return if dog == "back"
  dog.feed
  dog.print
end

def walk_dog
  puts "pick the number matching the dog you'd like to walk" 
  dog = prompt_user_to_choose_dog
  return if dog == "back"
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
  return if dog == "back"
  puts "Recent walks for #{dog.name}:"
  dog.walks.order(time: :desc).each do |walk|
    puts "time: #{walk.time.strftime('%A, %m/%d %l:%M %p')}"
  end
end

def list_feedings_for_dog
  puts "Which dog do you want to view past feedings for?"
  dog = prompt_user_to_choose_dog
  return if dog == "back"
  puts "Recent feedings for #{dog.name}:"
  dog.feedings.order(time: :desc).each do |walk|
    puts "time: #{walk.time.strftime('%A, %m/%d %l:%M %p')}"
  end
end

def create_walk
  options = Dog.all.reduce({}) do |memo, dog|
    memo[dog.name] = dog.id
    memo
  end
  dog_ids = PROMPT.multi_select("Which dogs would you like to take on the walk?", options)
  walk = Walk.create(time: Time.now, dog_ids: dog_ids)
  walk.print
end

def walk_info
  walk = PROMPT.select("Which walk would you like to choose?") do |menu|
    Walk.order(time: :desc).each do |walk|
      menu.choice walk.formatted_time, walk
    end
    menu.choice "back"
  end
  return if walk == "back"
  walk.print
end

def prompt_user_to_choose_dog
  PROMPT.select("Which dog would you like to choose?") do |menu|
    Dog.all.each do |dog|
      menu.choice dog.name, dog
    end
    menu.choice "back"
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