# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if User.find_by(email: "yixiu@yixiu.com").nil?
  a = User.new
  a.email = "yixiu@yixiu.com"           # 可以改成自己的 email
  a.name = "管理员"
  a.password = "123456"                # 最少要六码
  a.password_confirmation = "123456"   # 最少要六码
  a.is_admin = true
  a.save
  puts "管理员 已经建立好了，帐号为#{a.email}, 密码为#{a.password}"
else
  puts "管理员 已经建立过了，脚本跳过该步骤。"
end


Product.create!(title: "皮带",
                 description: "棕色，方便松紧",
                 category_id: "成品",
                 price: 300,
                 quantity: 10,
                 image: open("http://oon3erbcp.bkt.clouddn.com/%E7%9A%AE%E5%B8%A6.jpeg")
                 )
Product.create!(title: "牛皮",
                 description: "植糅革，会呼吸的皮革",
                 category_id: "材料",
                 price: 300,
                 quantity: 10,
                 image: open("http://oon3erbcp.bkt.clouddn.com/%E7%89%9B%E7%9A%AE1.jpg")
                 )
Product.create!(title: "裁皮刀",
                 description: "裁皮利器",
                 category_id: "工具",
                 price: 50,
                 quantity: 10,
                 image: open("http://oon3erbcp.bkt.clouddn.com/%E8%A3%81%E7%9A%AE%E5%88%80.jpg")
                 )
Product.create!(title: "物序手工鞋课程",
                  description: "邀你来做一双属于你自己的纯手工皮鞋",
                  category_id: "课程",
                  price: 2680,
                  quantity: 10,
                  image: open("http://oon3erbcp.bkt.clouddn.com/%E6%89%8B%E5%B7%A5%E9%9E%8B%E8%AF%BE%E7%A8%8B.jpeg")
                  )
