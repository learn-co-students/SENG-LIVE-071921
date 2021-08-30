DOGS = []

def start_cli
  puts "hello! Welcome to the Dog Walker CLI"
  print "What's your name? "
  name = gets.chomp
  puts "Hi #{name}"
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
  puts "  exit to leave the program".cyan
end

def handle_user_choice
  input = gets.chomp
  while input != "exit"
    if input == "1"
      dog = add_dog
      print_dog(dog)
    elsif input == "2"
      puts "All Dogs"
      DOGS.each do |dog|
        print_dog(dog)
      end
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
  dog = {
    name: dog_name,
    age: dog_age,
    breed: dog_breed,
    favorite_treats: favorite_treats
  }
  DOGS << dog
  dog
end

def print_dog(dog)
  puts ""
  puts dog[:name].light_green
  puts "  age: #{dog[:age]}"
  puts "  breed: #{dog[:breed]}"
  puts "  favorite_treats: #{dog[:favorite_treats]}"
  puts ""
end