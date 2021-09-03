DogWalk.destroy_all
Dog.destroy_all
Walk.destroy_all

dogs_attributes = [
  {
    name: "Lennon Snow",
    age: "11 months",
    breed: "Pomeranian",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1627585625/lennon-with-tennis-ball_slg2zn.jpg"
  },
  {
    name: "Olivia",
    age: "3 years",
    breed: "Terrier", 
    image_url: "https://i.imgur.com/zx6CPsp_d.webp?maxwidth=640&shape=thumb&fidelity=medium"
  },
  {
    name: "Molly",
    age: "2 years",
    breed: "Terrier / Chihuahua ", 
    image_url: "https://i.ibb.co/7YD99CK/EEE90-E50-25-F0-4-DF0-98-B2-0-E0-B6-F9-BAA89.jpg"
  },
  {
    name: "Kaya",
    age: "3 years",
    breed: "Blueheeler", 
    image_url: "https://scontent.fapa1-2.fna.fbcdn.net/v/t1.18169-9/21762207_10212937843515095_6836989904941765671_n.jpg?_nc_cat=102&ccb=1-3&_nc_sid=cdbe9c&_nc_ohc=d1fqbEnFq5QAX-4Lkf9&_nc_ht=scontent.fapa1-2.fna&oh=f0b2d77c14ba93b5e0f143f12267a7cc&oe=612849B7"
  },
  {
    name: "Ash",
    age: "2 years?",
    breed: "Husky",
    image_url: "https://images.unsplash.com/photo-1568572933382-74d440642117?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1575&q=80"
  },
  {
    name: "DJ",
    age: "2 years",
    breed: "Dachsund Mix",
    image_url: "https://pet-uploads.adoptapet.com/3/7/d/365758759.jpg"
  },
  {
    name: "Winter",
    age: "9 years",
    breed: "Husky Mix",
    image_url: "https://pet-uploads.adoptapet.com/c/d/d/561229495.jpg"
  },
  {
    name: "CeCe",
    age: "3 years",
    breed: "Lab mix",
    image_url: "https://ny-petrescue.org/files/_cache/ee7eee7ee62c9c2b053e65dc9c9e1a55.JPG"
  },
  {
    name: "Bert",
    age: "2 years",
    breed: "Terrier Mix",
    image_url: "https://ny-petrescue.org/files/_cache/cd48acb5e4f8a68d19453e5ec6cfe8bd.jpg"
  },
  {
    name: "Kane",
    age: "1 year",
    breed: "Terrier Mix",
    image_url: "https://ny-petrescue.org/files/_cache/06f5445919c408cb57e174b5ed726a66.jpg"
  },
  {
    name: "Nutmeg",
    age: "4 months",
    breed: "Lab Mix",
    image_url: "https://ny-petrescue.org/files/_cache/7487afba690331e10f7e63e3e4473191.jpg"
  },
  {
    name: "Sadie",
    age: "8 months",
    breed: "Lab/Terrier Mix",
    image_url: "https://ny-petrescue.org/files/_cache/55860f51e40159e2c34766352b214c36.jpg"
  },
  {
    name: "Sal",
    age: "2 years",
    breed: "Lab Mix",
    image_url: "https://ny-petrescue.org/files/_cache/83c97c9fe7d2d82ce90c1d8ca9fde44c.jpg"
  },
  {
    name: "Sebastian",
    age: "2 years",
    breed: "Wirehaired Jack Russel Terrier",
    image_url: "https://ny-petrescue.org/files/_cache/9d03c07fbd59d857f6beb92e627479d1.jpg"
  },
  {
    name: "Sinton",
    age: "2 years",
    breed: "Terrier Mix",
    image_url: "https://ny-petrescue.org/files/_cache/6752121299098441fc9e7510b2945963.jpeg"
  },
  {
    name: "Tommy",
    age: "11 weeks",
    breed: "Terrier Mix",
    image_url: "https://ny-petrescue.org/files/_cache/f7ae5a31bec815c4bf7bcd1f3242c844.jpg"
  },
  {
    name: "Cupcake",
    age: "2 months",
    breed: "???",
    image_url: "https://images6.fanpop.com/image/photos/41500000/it-s-national-dog-day-dogs-41538267-400-400.jpg"
  },
  {
    name: "CJ",
    age: "5 years",
    breed: "German shepard/shibainu", 
    image_url: "blob:https://imgur.com/4f93cf03-50cf-4037-be44-23df24b43d5c"
  },
  {
    name: "Frankie",
    age: "10 months",
    breed: "Boxer Mix", 
    image_url: "https://ibb.co/3SC5RfP"
  }
]

dogs = dogs_attributes.map{|attrs| Dog.create(attrs)}

walks_attributes = [
  
]

10.times {
  walks_attributes << {walk_time: [Date.today, DateTime.yesterday, DateTime.tomorrow].sample, dog_id: dogs.sample.id, number_two: [true, false].sample}
}

dog_walks = walks_attributes.map{|attrs| DogWalk.create(attrs)}

puts "#{Dog.count} dogs created"
puts "#{DogWalk.count} dog_walks created"
puts "#{Walk.count} walks created"