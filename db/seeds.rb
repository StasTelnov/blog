# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'httparty'
require 'faker'

# reset db
Rake::Task['db:reset'].invoke

# create users
user_names = []
100.times do
  user_names << Faker::Name.unique.first_name
end

# create ips

# create articles
100.times do
  HTTParty.post('http://0.0.0.0:3000/articles', {
      body: {
          article: {
              title: "Title2",
              content: "This will create development and test databases, set their owners to the user specified, and create. This table is used to record your migrations to schemas and data."
          },
          user: {
              nickname: user_names.sample
          }
      }
  })
end

# require 'httparty'
#
# options = {
#     body: {
#         :article => {
#             :title => "Title2",
#             :content => "This will create development and test databases, set their owners to the user specified, and create. This table is used to record your migrations to schemas and data."
#         },
#         :user => {
#             :nickname => "Pet"
#         }
#     }
# }
#
# # You can also use post, put, delete, head, options in the same fashion
# 1000.times do
#   HTTParty.post('http://0.0.0.0:3000/articles', options)
# end
# response = HTTParty.post('http://0.0.0.0:3000/articles', options)
# puts response.body, response.code, response.message, response.headers.inspect
