@admin = AdminUser.create(email: "admin@test.com",
                           password:"foobar",
                           password_confirmation:"foobar",
                           first_name: "test",
                           last_name:"mctester",
                           phone: "5129949730")
puts "1 Admin User created"

@user = User.create(email: "email@test.com",
                    password:"foobar",
                    password_confirmation:"foobar",
                    first_name: "jon",
                    last_name:"Snow",
                    phone: "5129949730"
                    )
puts "1 User created"

100.times do |post|
  Post.create(date: Date.today, rationale: "How long before you can make the jump to light speed? It'll take a few moments to get the coordinates from the navi-computer. Are you kidding? At the rate they're gaining... Traveling through hyperspace isn't like dusting crops, boy! Without precise calculations we could fly right through a star or bounce too close to a supernova and that'd end your trip real quick, wouldn't it? What's that flashing? We're losing our deflector shield. Go strap yourself in, I'm going to make the jump to light speed.", user_id: @user.id, overtime_request:2.5)
end
puts "100 Posts have been created"

100.times do |audit_log|
  AuditLog.create!(user_id: User.last.id, status: 0, start_date: (Date.today - 6.days))
end

puts "100 Audit Logs have been created"
