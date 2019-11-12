require_relative('../models/city.rb')
require_relative('../models/country.rb')
require('pry-byebug')

City.delete_all()
Country.delete_all()

country1 = Country.new({
  "name" => "United Kingdom",
  "visited" => "false"
  })
country1.save()

country2 = Country.new({
  "name" => "France",
  "visited" => "false"
  })
country2.save()

country3 = Country.new({
  "name" => "Spain",
  "visited" => "true"
  })
country3.save()

city1 = City.new({
  "name" => "London",
  "visited" => "false",
  "country_id" => country1.id
  })
city1.save()

city2 = City.new({
  "name" => "Brighton",
  "visited" => "true",
  "country_id" => country1.id
  })
city2.save()

city3 = City.new({
  "name" => "Paris",
  "visited" => "false",
  "country_id" => country2.id
  })
city3.save()

city4 = City.new({
  "name" => "Barcelona",
  "visited" => "true",
  "country_id" => country3.id
  })
city4.save()


binding.pry
nil
