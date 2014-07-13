# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create an admin
if User.exists?
  user = User.order("id asc").first
  user.role = "admin"
  user.save!
else
  # untested. Should be fine though
  user = User.new
  user.email = "admin@admin.com"
  user.username = "admin"
  user.password = "admin"
  user.password_confirmation = "admin"
  user.role = "admin"
  user.save!
end