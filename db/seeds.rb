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
Table.destroy_all
RestaurantServer.destroy_all
Restaurant.destroy_all
User.destroy_all

puts "Create User database..."

owner = User.create!(
  email: "owner@lewagon.com",
  password: "lewagon",
  first_name: "owner",
  last_name: "lewagon",
  is_owner: true
)

i = 1
4.times do
  puts "Create Restaurant database..."

  restaurant = Restaurant.create!(
    name: Faker::Restaurant.name,
    address: "204 Brick Lane Shoreditch, London, E1 6SA, England",
    phone_number: Faker::PhoneNumber.cell_phone_in_e164,
    theme_color: "blue",
    user_id: owner.id
  )

  5.times do
    puts "Create Table database..."

    server = User.create!(
      email: "server#{i}@lewagon.com",
      password: "lewagon",
      first_name: "server",
      last_name: "lewagon",
      is_owner: false
    )

    i += 1

    table = Table.create!(
      restaurant_id: restaurant.id
    )

    table_order = TableOrder.create!(
      is_active: true,
      total_price: 0,
      table_id: table.id,
      user_id: server.id
    )

    table_captain = TableCustomer.create!(
      name: "Captain",
      is_captain: true,
      table_order_id: table_order.id
    )

    table_customer1 = TableCustomer.create!(
      name: "Customer1",
      table_order_id: table_order.id,
    )

    table_customer2 = TableCustomer.create!(
      name: "Customer2",
      table_order_id: table_order.id,
    )

    table_customer3 = TableCustomer.create!(
      name: "Customer3",
      table_order_id: table_order.id,
    )

    puts "Create RestaurantServer database..."
      RestaurantServer.create!(
        restaurant_id: restaurant.id,
        user_id: server.id
      )
  end

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
