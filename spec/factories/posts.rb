FactoryGirl.define do
  factory :post do
    date Date.today
    work_performed "Some Work Performed"
    user
    daily_hours 12.0
  end

  factory :second_post, class: "Post" do
    date Date.yesterday
    work_performed "Some more content"
    user
    daily_hours 11.5
  end

  factory :post_from_other_user, class: "Post" do
    date Date.yesterday
    work_performed "And Some more content"
    user
    daily_hours 8.0
  end
end
