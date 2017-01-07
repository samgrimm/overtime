@user = User.create(email: "email@test.com", password:"foobar", password_confirmation:"foobar", first_name: "jon", last_name:"Snow")

100.times do |post|
  Post.create(date: Date.today, rationale: "#{post} rationale content", user_id: @user.id)
end

puts "100 Posts have been created"
