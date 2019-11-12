require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/city.rb' )
require_relative( '../models/country.rb' )
also_reload( '../models/*' )

get '/visited' do
  @name = "Visited"
  @countries = Country.visited()
  erb(:'countries/index')
end

# get '/visited/:id' do
#   @country = Country.find(params['id'].to_i)
#   @cities = Country.show_cities_visited(params['id'].to_i)
#   erb(:"visited/country/index")
# end
#
get '/unvisited' do
  @countries = Country.unvisited()
  erb(:'countries/index')
end
#
# get '/unvisited/:id' do
#   @country = Country.find(params['id'].to_i)
#   @cities = Country.show_cities_unvisited(params['id'].to_i)
#   erb(:"unvisited/country/index")
# end
