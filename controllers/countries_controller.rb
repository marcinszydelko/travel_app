require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/city.rb' )
require_relative( '../models/country.rb' )
also_reload( '../models/*' )

get '/visited' do
  @name = "Visited"
  @countries = Country.visited()
  erb(:'countries/index')
end

get '/visited/:id' do
  @status = "visited"
  @country = Country.find(params['id'].to_i)
  @cities = Country.show_cities_visited(params['id'].to_i)
  erb(:"cities/index")
end

# get '/unvisited' do # doesnt work
#   @name = "Unvisited"
#   @countries = Country.unvisited()
#   erb(:'countries/index')
# end

get '/visited/new' do
  @countries = Country.visited()
  erb(:"countries/new")
end

post '/visited' do
  country = Country.new(params)
  country.save
  redirect to ("/visited")
end
#
# get '/unvisited/:id' do
#   @country = Country.find(params['id'].to_i)
#   @cities = Country.show_cities_unvisited(params['id'].to_i)
#   erb(:"unvisited/country/index")
# end
