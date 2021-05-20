FactoryBot.define do
  factory :user do
    username {"TestUser"}
    password {"1234567"}
    password_confirmation {"1234567"}

    trait :locked do
      login_attempts {3}
      locked { true }
    end

    trait :short_named do 
      username {'short'}
    end

    trait :short_password do 
      password {'1234'}
      password_confirmation {'1234'}
    end
    
    trait :long_password do 
      password {'1234567890qwerty12345'}
      password_confirmation {'1234567890qwerty12345'}
    end
    
    trait :long_named do 
      username {'ThisIsaBigNameForaUser'}
    end

    trait :nameless do 
      username {nil}
    end
  factory :locked_user, traits: [:locked]
  factory :long_named_user, traits: [:long_named]
  factory :short_named_user, traits: [:short_named]
  factory :nameless_user, traits: [:nameless]
  factory :short_password_user, traits: [:short_password]
  factory :long_password_user, traits: [:long_password]

  end
end