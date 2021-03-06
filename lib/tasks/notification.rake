namespace :notification do
  desc "Sends SMS notification to employees asking them to log if they had overtime"
  task sms: :environment do
    if Time.now.sunday?
      employees = Employee.all
      notification_message = "Please log into the overtime management dashboard
      to request overtime or confirm your hours for last week: https://sam-overtime.herokuapp.com/"
      employees.each do |employee|
        AuditLog.create!(user_id: employee.id)
        SmsTool.send_sms(number: employee.phone, message: notification_message)
      end
    end
  end

  desc "Sends email notification to managers each day to inform them of pending overtime requests"
  task manager_email: :environment do
    #1. Iterate over the list of pending overtime requests
    #2. Check if there are any requests
    #3. Iterate over the list of managers
    #4. Send email to each manager
    submitted_posts = Post.submitted
    admin_users = AdminUser.all
    admin_users.each do |admin|
      ManagerMailer.email(admin).deliver_now
    end
  end

end
