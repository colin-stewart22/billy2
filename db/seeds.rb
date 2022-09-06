# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Destroy all database..."
JoinMenu.destroy_all
Menu.destroy_all
MenuItem.destroy_all
TableCustomer.destroy_all
Restaurant.destroy_all
User.destroy_all
Table.destroy_all

puts "Create User database..."

owner = User.create!(
  email: "owner@lewagon.com",
  password: "lewagon",
  first_name: "owner",
  last_name: "lewagon",
  is_owner: true
)

server = User.create!(
  email: "server@lewagon.com",
  password: "lewagon",
  first_name: "server",
  last_name: "lewagon",
  is_owner: false
)

2.times do
  puts "Create Restaurant database..."
  restaurant = Restaurant.create!(
    name: Faker::Restaurant.name,
    address: "204 Brick Lane Shoreditch, London, E1 6SA, England",
    phone_number: Faker::PhoneNumber.cell_phone_in_e164,
    theme_color: "blue",
    user_id: owner.id
  )
  3.times do
    puts "Create Menu database..."
    menu = Menu.create!(
      name: ["Summer", "Holiday", "Winter"].sample,
      restaurant_id: restaurant.id
    )
    10.times do
      puts "Create MenuItem database..."
      menu_item = MenuItem.create!(
        name: Faker::Food.dish,
        category: ["Breakfast", "Lunch", "Dinner", "Starters", "Mains", "Desserts", "Drinks"].sample,
        description: Faker::Food.description,
        price: rand(1..50),
        prepare_time: rand(5..30),
        restaurant_id: restaurant.id
      )
      puts "Create JoinMenu database..."
      JoinMenu.create!(
        menu_id: menu.id,
        menu_item_id: menu_item.id
      )
    end
  end
end

puts "Completed!"
