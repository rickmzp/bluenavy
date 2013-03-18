FactoryGirl.define do

  factory :game do
    player_1 { build(:player) }

    trait :started do
      player_2 { build(:player) }
      started { true }
    end
  end

  factory :player do
    user { User.named(Faker::Name.name) }
  end

  factory :navy do
  end

end
