dogs_attributes = [
  {
    name: "Olivia",	
    birthdate: Date.new(2018, 03, 31),
    breed:	"Terrier",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1631229064/zx6CPsp_d_utkmww.webp"
  },
  {
    name: "Molly",	
    birthdate: Date.new(2019,06, 21),
    breed:	"Terrier / Chihuahua",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1631229038/EEE90-E50-25-F0-4-DF0-98-B2-0-E0-B6-F9-BAA89_menwgg.jpg"  
  },
  {
    name: "Kaya",	
    birthdate: Date.new(2017, 9, 27),
    breed:	"Blueheeler",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1631229011/8136c615d670e214f80de4e7fcdf8607--cattle-dogs-mans_vgyqqa.jpg"
  },
  {
    name: "Chop",	
    birthdate: Date.new(2020, 7, 31),
    breed:	"German Shorthaired Pointer",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1629822267/cdbd77592e3ef91e8cc1cf67d936f94f_fkozjt.jpg"
  },
  {
    name: "Baron",	
    birthdate: Date.new(2012, 12, 23),
    breed:	"GSD/English Lab mix",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1629567379/baron_x0s6ai.jpg"
  },
  {
    name: "Lennon Snow",
    birthdate: 11.months.ago,
    breed: "Pomeranian",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1627585625/lennon-with-tennis-ball_slg2zn.jpg"
  },
  {
    name: "Ash",
    birthdate: 2.years.ago,
    breed: "Husky",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1631229192/photo-1568572933382-74d440642117_p6mrgm.jpg"
  },
  {
    name: "DJ", 
    birthdate: 2.years.ago,
    breed: "Dachsund Mix",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1629822169/365758759_qyupo8.jpg"
  },
  {
    name: "Winter",
    birthdate: 9.years.ago,
    breed: "Husky Mix",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1629822144/561229495_lldnll.jpg"
  },
  {
    name: "CeCe",
    birthdate: 3.years.ago,
    breed: "Lab mix",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1629821709/ee7eee7ee62c9c2b053e65dc9c9e1a55_iwjweh.jpg"
  },
  {
    name: "Kane",
    birthdate: 1.year.ago,
    breed: "Terrier Mix",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1629821681/2_lu9ccw.jpg"
  },
  {
    name: "Nutmeg",
    birthdate: 4.months.ago,
    breed: "Lab Mix",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1629822016/Nutmegupdate97_kyqlqo.jpg"
  },
  {
    name: "Sadie",
    birthdate: 8.months.ago,
    breed: "Lab/Terrier Mix",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1629822095/55860f51e40159e2c34766352b214c36_g3plyx.jpg"
  },
  {
    name: "Sal",
    birthdate: 2.years.ago,
    breed: "Lab Mix",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1629822067/83c97c9fe7d2d82ce90c1d8ca9fde44c_zckdjy.jpg"
  },
  {
    name: "Sinton",
    birthdate: 2.years.ago,
    breed: "Terrier Mix",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1629821474/4_bbgw1p.jpg"
  },
  {
    name: "Cupcake",
    birthdate: 2.months.ago,
    breed: "???",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1631229142/it-s-national-dog-day-dogs-41538267-400-400_fvq8wk.jpg"
  },
  {
    name: "Luci",
    birthdate: 2.years.ago,
    breed: "Samoyed",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1629822371/f6p9jE2_acndnl.jpg"
  },
  {
    name: "Simon",
    birthdate: Date.new(2015, 8, 23),
    breed: "Shiba Inu",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1629822438/B3-FAF888-5656-4746-BE22-597185404078_bpbvvs.jpg"
  },
  {
    name: "Snoopy",
    birthdate: Date.new(1990,1,1),
    breed: "Snooop",
    image_url: "https://res.cloudinary.com/dnocv6uwb/image/upload/v1629822337/sn-color_qesmhx.jpg"
  },
]


dogs = dogs_attributes.map{|attrs| Dog.create(attrs)}

walks_attributes = [
  {time: 1.day.ago},
  {time: 3.hours.ago},
  {time: 5.hours.ago}
]

walks = walks_attributes.map do |attrs| 
  Walk.create(attrs)
end


puts "#{Dog.count} dogs created"
puts "#{DogWalk.count} dog_walks created"
puts "#{Walk.count} walks created"