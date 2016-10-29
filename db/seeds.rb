# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# SEED_FILES=04-videos rake db:seed
# RAILS_ENV=production SEED_FILES=02-students bundle exec rake db:seed

puts "Seeding data"

def load_rb(seed)
  require 'yaml'
  require 'csv'
  puts "#{Time.now} | Execute seed #{seed.inspect}"
  require "#{seed}"
  klass_name = ("seed_" + File.basename("#{seed}", '.rb').split('-').last).classify
  klass = klass_name.constantize
  klass.seed
end

if ENV['SEED_FILES'].present?
  seed_files = ENV['SEED_FILES'].split(',')
  seed_files.each do |seed_name|
    load_rb("#{Rails.root}/db/seeds/#{seed_name}.rb")
  end
else
  Dir["#{Rails.root}/db/seeds/**/*.rb"].sort.each do |seed|
    load_rb(seed)
  end
end

puts "Done!"
