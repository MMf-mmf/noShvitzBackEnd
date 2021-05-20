# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.destroy_all
User.destroy_all
Product.destroy_all
Order.destroy_all

puts "Destroyed Data"

user_1 = Client.create(email: "menachemfuterfas@gmail.com", name: "menachem", ghoneNumber1: 7187743214, ghoneNumber2: 6462345678, address: "435 windler rd", active: false, admin: false, employee: false)
user_2 = Client.create(email: "menachem@gmail.com", name: "zalman", ghoneNumber1: 6787743214, ghoneNumber2: 8762345678, address: "434 windler rd", active: false, admin: false, employee: false)

category_1 = Categories.create(name: "wine")
category_2 = Category.create(name: "meet")

product_1 = Product.create(name: "bartenura", company: "kedem", category_id: 1, weight: nill, price: 156 )
product_2 Product.create(name: "chicken legs", company: "robashken", category_id 2, weight: nill, price: 204)

orders_1 = Order.create(user_id: 1, product_id 1, total: )
