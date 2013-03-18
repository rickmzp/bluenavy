FactoryGirl.define do

  factory :game do
    player_1 { build(:player) }
  end

  factory :player do
    user { User.named(Faker::Name.name) }
  end

  factory :navy do
  end

end
