FactoryGirl.define do

  factory :game do
    player_1 { build(:player) }

    trait :in_progress do
      player_2 { build(:player) }
    end
  end

  factory :player do
    user { User.named(Faker::Name.name) }
    navy { build(:navy) }
  end

  factory :user do
    ignore do
      name { Faker::Name.name }
    end

    initialize_with do
      User.named(name)
    end
  end

  factory :navy do
    strategy { NavalStrategy.generate_for(self) }
  end

  factory :ship do
    name { Faker::Company.name }
    size { rand(3) + 1 }
  end

end
