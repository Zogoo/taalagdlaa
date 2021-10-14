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
companies = create_list(:company, 25, :with_logo, category: categories.sample)

# Users
users = create_list(:user, 25, :with_avatar)

# Review and comments
create_list(:review, 50, :with_pothos, company: companies.sample, user: users.sample)
