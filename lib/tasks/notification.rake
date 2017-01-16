namespace :notification do
  desc "Sends SMS notification to employees asking them to log if they had overtime"
  task sms: :environment do
    if Time.now.sunday?
    end
    #1. Schedule to run on Sunday at 5pm
    #2. Iterate over all employees
    #3. Skip admin users
    #4. Send a message with instructions and a link to log time
    # User.all.each do |user|
    #   SmsTool.send_sms()
    # end
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
