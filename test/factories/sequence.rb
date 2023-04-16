FactoryBot.define do
  sequence :string, aliases: [:first_name, :last_name, :password, :avatar] do |n|
    "string#{n}"
  end

  sequence :email do |n|
    "person#{n}@example.com"
  end

  sequence :type, %w[Admin Developer Manager].cycle
end
