namespace :notification do
  desc "Sends SMS notification to employees asking them to log if they had overtime"
  task sms: :environment do
    puts "I am a rake task"
  end

end
