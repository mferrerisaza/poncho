class Subscription < ApplicationRecord
  enum plan: [:bike, :scooter]
end
