FactoryGirl.define do

  factory :game do
    player_1 { build(:player) }

    trait :started do
      player_2 { build(:player) }
      started { true }

      after(:build) do |game|
        game.ready! game.player_2 if game.player_2.present?
      end
    end

    after(:build) do |game|
      game.ready! game.player_1 if game.player_1.present?
    end
  end

  factory :player do
    name { Faker::Name.name }
  end

  factory :navy do
  end

end
