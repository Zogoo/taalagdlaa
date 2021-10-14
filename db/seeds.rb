# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
include FactoryBot::Syntax::Methods

# Company categories
categories = create_list(:category, 20)

# Companies
companies = 25.times.map do
  create(:company, :with_logo, category: categories.sample)
end

# Users
users = 50.times.map do
  create(:user, :with_avatar)
end

# Review and comments
100.times.map do
  create(:review, :with_pothos, company: companies.sample, user: users.sample)
end
