require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Examples:

#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



Category.destroy_all
User.destroy_all
Product.destroy_all
Order.destroy_all

puts "Destroyed Data"

user1 = User.create!(email: "menachemfuterfas@gmail.com", name: "menachem frank", phoneNumber1: 7187743214, phoneNumber2: 6462345678, address: "435 windler rd",  activated: true, activated_at: Time.zone.now, admin: false, employee: false, password: "passpass", password_confirmation: "passpass")
user2 = User.create!(email: "menachem@gmail.com", name: "zalman heller", phoneNumber1: 6787743214, phoneNumber2: 8762345678, address: "434 windler rd",  activated: true, activated_at: Time.zone.now,  admin: true, employee: false, password: "passpass", password_confirmation: "passpass")


# 20.times do 
#     User.create(
#         email: Faker::Internet.email,
#         name: Faker::Name.name,
#         phoneNumber1: Faker::PhoneNumber.cell_phone,
#         phoneNumber2: Faker::PhoneNumber.cell_phone,
#         address: Faker::Address.full_address,
#         password: Faker::Internet.password,
#         activated: false, admin: false, employee: false
#     )
# end


# Faker::Address.full_address
# Faker::Name.name
# Faker::PhoneNumber.cell_phone
# Faker::Internet.email

cat1 = Category.create!(name: "wine", category_id: 1, deadline: '2/5/2023', image: "https://image.freepik.com/free-photo/glass-bottle-with-delicious-red-wine-table-against-wooden_127657-3953.jpg")
cat2 = Category.create!(name: "meat", category_id: 2, deadline: '2/5/2023', image: "https://static.fanpage.it/wp-content/uploads/sites/22/2018/11/raw-meat.jpg")
cat3 = Category.create!(name: "produce", category_id: 3, deadline: '2/5/2023', image: "http://community.farmhousedelivery.com/wp-content/uploads/2018/06/FHD_20180619_Produce-Box.jpg")






product1 = Product.create!(name: "bartenura", company: "kedem", category_id: cat1.id, price: 156.00, image: "https://cdn.shopify.com/s/files/1/0076/4392/2502/products/bartenura2_eb512d2f-f959-4446-8c69-54284e960869_1200x1200.jpg?v=1564582314", limit: 5)
product2 = Product.create!(name: "rashi light", company: "kedem", category_id: cat1.id,  price: 89.00, image: "https://www.kosherwine.com/media/catalog/product/cache/fed39a435672b8879156f3629775689d/r/a/rashi-light-pink-concord-15358-base.jpg",  limit: 5)
product5 = Product.create!(name: "rashi dark", company: "kedem", category_id: cat1.id,  price: 90.00, image: "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fcdn.shopify.com%2Fs%2Ffiles%2F1%2F2005%2F1601%2Fproducts%2F1_f964083c-a356-42d0-9ad5-0dd2ca18afce.png%3Fv%3D1500860672&f=1&nofb=1",  limit: 5)
product6 = Product.create!(name: "Lueria", company: "kedem", category_id: cat1.id,  price: 99.00, image: "https://i.pinimg.com/originals/20/95/33/209533fd16c5153ad55de03455c8f3ec.png",  limit: 5)
product12 = Product.create!(name: "Dalton", company: "galil", category_id: cat1.id,  price: 99.00, image: "https://assets.healthytokyo.com/wp-content/uploads/20180820104343/7290014503830A.jpg",  limit: 5)
product13 = Product.create!(name: "Yarden", company: "kedem", category_id: cat1.id,  price: 99.00, image: "https://israelifooddirect.com/wp-content/uploads/2019/09/yarden-viognier-kosher-wines.png",  limit: 5)
product14 = Product.create!(name: "Flam", company: "kedem", category_id: cat1.id,  price: 99.99, image: "https://www.kosherwine.co.uk/images/flam-syrah-reserve-p3828-10444_image.jpg",  limit: 5)
product15 = Product.create!(name: "Concord kal", company: "kedem", category_id: cat1.id,  price: 99.99, image: "https://www.kosherwine.co.uk/images/kedem-concord-kal-1-5-litre-p3635-9399_image.jpg",  limit: 5)
product16 = Product.create!(name: "Or haganuz", company: "kedem", category_id: cat1.id,  price: 99.99, image: "https://cdn.shopify.com/s/files/1/0076/4392/2502/products/or-haganuz_elima_530x@2x.jpg?v=1580073236" ,  limit: 5)
product17 = Product.create!(name: "smaberg", company: "kedem", category_id: cat1.id,  price: 99.99, image: "https://i.pinimg.com/originals/20/95/33/209533fd16c5153ad55de03455c8f3ec.png" ,  limit: 5)

product3 = Product.create!(name: "chicken legs", company: "robashken", category_id: cat2.id, price: 2.89, image: "https://www.springfieldpoultry.co.uk/wp-content/uploads/2016/12/SP63888.jpg" ,  limit: 5)
product4 = Product.create!(name: "chicken wings", company: "robashken", category_id: cat2.id,  price: 0.89, image: "http://www.thecrownmarket.com/wp-content/uploads/2018/10/raw-chicken-wings.jpg" ,  limit: 5)
product12 = Product.create!(name: "Lamb chops", company: "Star", category_id: cat2.id,  price: 7.89, image: "https://thejewishkitchen.com/wp-content/uploads/2016/06/lamb-chops4.jpg" ,  limit: 5)
product13 = Product.create!(name: "Boneless chicken breast", company: "robashken", category_id: cat2.id,  price: 9.89, image: "https://blog.thermoworks.com/wp-content/uploads/2018/02/iStock_45233784_LARGE.jpg" ,  limit: 5)

product7 = Product.create!(name: "Bananas", company: "Winthrop Groman", category_id: cat3.id,  price: 2.50, image: "https://freyaproduce.com/wp-content/uploads/bunch-of-bananas.jpg" ,  limit: 5)
product8 = Product.create!(name: "Carrots", company: "Guardian", category_id: cat3.id,  price: 3.50, image: "https://www.ugaoo.com/knowledge-center/wp-content/uploads/2016/05/carrots-1.jpg",  limit: 5)
product9 = Product.create!(name: "Watermelon", company: " Lockheed Martin", category_id: cat3.id,  price: 5.50, image: "https://www.ahealthiermichigan.org/wp-content/uploads/2012/06/close-up-delicious-fruit-1068534.jpg" ,  limit: 5)
product10 = Product.create!(name: "Apples", company: "IKEA", category_id: cat3.id,  price: 6.50, image: "https://seattle.cbslocal.com/wp-content/uploads/sites/15909838/2011/09/120716788.jpg?w=1500" ,  limit: 5)





# order1 = Order.create!(user_id: user1.id, category_id: cat1.id, employee_id: nil, total: 0, notes: nil, fulfilled: false, cart: true, submitted: false)
# order2 = Order.create!(user_id: user1.id, category_id: cat2.id, employee_id: nil, total: 0, notes: nil, fulfilled: false, cart: true, submitted: false)


# orderd1 = OrderDetail.create!(order_id: order1.id, product_id: product1.id, quantity: 5)
# orderd2 = OrderDetail.create!(order_id: order1.id, product_id: product2.id, quantity: 2)
# OrderDetail.create!(order_id: order1.id, product_id: product5.id, quantity: 4)
# OrderDetail.create!(order_id: order1.id, product_id: product6.id, quantity: 6)



# orderd3 = OrderDetail.create!(order_id: order2.id, product_id: product3.id, quantity: 4)
# orderd3 = OrderDetail.create!(order_id: order2.id, product_id: product4.id, quantity: 5)




# query to get the 
# cart.find_by(id: 1).order_details.first.product.company

# query to find all cart items form a selected user and a selected category / company
#cart.find_by(user_id: 1).order_details.where("product.company" =='kedem').last.product.company