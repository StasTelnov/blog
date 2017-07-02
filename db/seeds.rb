# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'httparty'
require 'faker'
require 'database_cleaner'

begin
  base_path = 'http://0.0.0.0:3000'
  HTTParty.get(base_path)
rescue Errno::ECONNREFUSED => e
  puts e.message
  puts'=== YOU SHOULD RUN RAILS SERVER'
else
  puts '=== CLEAR DB'
  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.clean

  puts '=== SEED DATA START POPULATED'
  # create users
  user_names = []
  100.times do
    user_names << Faker::Internet.unique.user_name
  end

  # create ips
  ip_v4_address = []
  50.times do
    ip_v4_address << Faker::Internet.unique.ip_v4_address
  end

  # create articles
  create_article_path = base_path + '/articles'
  200.times do |n|
    1000.times do
      response = HTTParty.post(create_article_path, {
          body: {
              article: {
                  title: Faker::Name.title,
                  content: Faker::Lorem.paragraph,
                  user_ip: ip_v4_address.sample
              },
              user: {
                  nickname: user_names.sample
              }
          }
      })

      # create rating by the article
      if rand(1..10) == 10 # every tenth
        article_id = response.parsed_response['id']
        create_rating_path = base_path + "/articles/#{article_id}/ratings"
        options = {
            body: {
                rating: {
                    value: nil
                }
            }
        }

        rand(1..5).times do
          options[:body][:rating][:value] = rand(1..5)
          HTTParty.post(create_rating_path, options)
        end
      end
    end
    puts "=== #{n + 1} thousand articles populated"
  end
  puts '=== SEED DATA FINISH POPULATED'
end

