FactoryBot.define do
  factory :user do
    username {"TestUser"}
    password {"1234567"}
    password_confirmation {"1234567"}

    trait :locked do
      login_attempts {3}
      locked { true }
    end


  factory :locked_user, traits: [:locked]
  end
end