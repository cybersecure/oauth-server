# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

c = ClientApplication.new
c.client_id = "abc123"
c.client_secret = "def123"
c.client_url = "http://storage1:3001"
c.description = "Something interesting"
c.client_name = "TestApp1"
c.save
