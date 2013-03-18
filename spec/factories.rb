FactoryGirl.define do

  factory :game do
    player_1 { Faker::Name.name }
  end

end
