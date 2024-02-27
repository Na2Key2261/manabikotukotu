def create_random_post(user)
  learning_items = {
    1 => '経済学・経済政策',
    2 => '財務・会計',
    3 => '企業経営理論',
    4 => '運営管理',
    5 => '経営法務',
    6 => '経営情報システム',
    7 => '中小企業経営・政策',
    8 => '事例Ⅰ',
    9 => '事例Ⅱ',
    10 => '事例Ⅲ',
    11 => '事例Ⅳ'
  }
  learning_item = learning_items.keys.sample
  learning_hour = rand(1..8)
  learning_content = "I learned #{learning_items[learning_item]} for #{learning_hour} hours today."
  
  user.posts.create!(
    learning_item: learning_item,
    learning_hour: learning_hour,
    learning_content: learning_content
  )
end

users = [
  { name: 'Alice', email: 'alice@example.com', password: 'passAlice' },
  { name: 'Bob', email: 'bob@example.com', password: 'passBob' },
  { name: 'Charlie', email: 'charlie@example.com', password: 'passCharlie' }
]

users.each do |user_attrs|
  user = User.find_or_create_by!(email: user_attrs[:email]) do |u|
    u.name = user_attrs[:name]
    u.password = user_attrs[:password]
  end

  create_random_post(user)
end

puts 'Test data created successfully'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
