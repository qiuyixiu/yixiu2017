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
