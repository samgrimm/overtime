@user = User.create(email: "email@test.com", password:"foobar", password_confirmation:"foobar", first_name: "jon", last_name:"Snow")
puts "1 User created"

@admint = AdminUser.create(email: "admin@test.com", password:"foobar", password_confirmation:"foobar", first_name: "test", last_name:"mctester")
puts "1 Admin User created"

100.times do |post|
  Post.create(date: Date.today, rationale: "#{post} rationale content", user_id: @user.id)
end

puts "100 Posts have been created"
