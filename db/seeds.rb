# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Destroy OrderItem database..."
OrderItem.destroy_all
puts "Destroy JoinMenu database..."
JoinMenu.destroy_all
puts "Destroy Menu database..."
Menu.destroy_all
puts "Destroy MenuItem database..."
MenuItem.destroy_all
puts "Destroy TableCustomer database..."
TableCustomer.destroy_all
puts "Destroy TableOrder database..."
TableOrder.destroy_all
puts "Destroy Table database..."
Table.destroy_all
puts "Destroy RestaurantServer database..."
RestaurantServer.destroy_all
puts "Destroy Restaurant database..."
Restaurant.destroy_all
puts "Destroy User database..."
User.destroy_all

puts "Create owner database..."

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

  5.times do
    puts "Create Server database..."

    server = User.create!(
      email: "server#{i}@lewagon.com",
      password: "lewagon",
      first_name: "server",
      last_name: "lewagon",
      is_owner: false
    )

    puts "Create Table database..."
    table = Table.create!(
      restaurant_id: restaurant.id,
      table_number: i,
      qr_code: ""
    )


    puts "Create TableOrder database..."
    table_order = TableOrder.create!(
      is_active: true,
      total_price: 0,
      table_id: table.id,
      user_id: server.id
    )

    puts "Create Table_captain database..."
    table_captain = TableCustomer.create!(
      name: "Captain",
      is_captain: true,
      table_order_id: table_order.id
    )

    3.times do
      puts "Create Table_captain OrderItem database..."
      OrderItem.create!(
        estimated_serving_time: (5..60).to_a.select { |num| (num % 5).zero? }.sample,
        menu_item_id: Menu.all[i - 1].menu_items.sample.id,
        table_customer_id: table_captain.id
      )
    end

    puts "Create Table_customer1 database..."
    table_customer1 = TableCustomer.create!(
      name: "Customer1",
      table_order_id: table_order.id
    )

    3.times do
      puts "Create Table_customer1 OrderItem database..."
      OrderItem.create!(
        estimated_serving_time: (5..60).to_a.select { |num| (num % 5).zero? }.sample,
        menu_item_id: Menu.all[i - 1].menu_items.sample.id,
        table_customer_id: table_customer1.id
      )
    end

    puts "Create Table_customer2 database..."
    table_customer2 = TableCustomer.create!(
      name: "Customer2",
      table_order_id: table_order.id
    )

    3.times do
      puts "Create Table_customer2 OrderItem database..."
      OrderItem.create!(
        estimated_serving_time: (5..60).to_a.select { |num| (num % 5).zero? }.sample,
        menu_item_id: Menu.all[i - 1].menu_items.sample.id,
        table_customer_id: table_customer2.id
      )
    end

    puts "Create Table_customer3 database..."
    table_customer3 = TableCustomer.create!(
      name: "Customer3",
      table_order_id: table_order.id
    )

    3.times do
      puts "Create Table_customer3 OrderItem database..."
      OrderItem.create!(
        estimated_serving_time: (5..60).to_a.select { |num| (num % 5).zero? }.sample,
        menu_item_id: Menu.all[i - 1].menu_items.sample.id,
        table_customer_id: table_customer3.id
      )
    end

    puts "Create RestaurantServer database..."
      RestaurantServer.create!(
        restaurant_id: restaurant.id,
        user_id: server.id
      )

    i += 1
  end
end

puts "Completed!"
