FactoryGirl.define do
  factory :university do |uni|
    uni.rank { 10 }
    uni.university_name { Faker::University.name }
    uni.university_type { 'Private' }
  end
end