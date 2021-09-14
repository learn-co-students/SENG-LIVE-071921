puts "🌱 Seeding spices..."

# Seed your database here
top_left_office_drawer = Spot.create(name: "Top Left Office Drawer")
middle_left_office_drawer = Spot.create(name: "Middle Left Office Drawer")
bottom_left_office_drawer = Spot.create(name: "Bottom Left Office Drawer")

top_right_office_drawer = Spot.create(name: "Top Right Office Drawer")
middle_right_office_drawer = Spot.create(name: "Middle Right Office Drawer")
bottom_right_office_drawer = Spot.create(name: "Bottom Right Office Drawer")

top_closet_shelf = Spot.create(name: "Top Closet Shelf")

top_closet_shelf.things.create(name: "Circular Saw", category: "Tools")
top_closet_shelf.things.create(name: "60 tooth carbide blade", category: "Tools")

bottom_left_office_drawer.things.create(name: "Midi Keyboard", category: "Music")
bottom_left_office_drawer.things.create(name: "Condenser Microphone", category: "Music")

top_left_office_drawer.things.create(name: "USB Hub", category: "Electronics")

top_right_office_drawer.things.create(name: "Laptop Charger", category: "Electronics")

bottom_right_office_drawer.things.create(name: "Electric Drill/Driver", category: "Tools")


puts "✅ Done seeding!"
