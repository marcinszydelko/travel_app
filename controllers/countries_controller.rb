require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/city.rb' )
require_relative( '../models/country.rb' )
also_reload( '../models/*' )

get '/visited' do
  @name = "visited"
  @countries = Country.visited()
  erb(:'countries/index')
end

get '/visited/new' do
  @status = "visited"
  # @country = Country.visited()
  erb(:"countries/new")
end

get '/unvisited/new' do
  @status = "unvisited"
  # @country = Country.unvisited()
  erb(:"countries/new")
end

post '/visited' do
  @country = Country.new(params)
  @country.save
  redirect to ("/cities/new/#{@country.id}")
end

# post '/unvisited' do
#   @country = Country.new(params)
#   @country.save
#   redirect to ("/cities/new/#{@country.id}")
# end

get '/visited/:id' do
  @status = "visited"
  @country = Country.find(params['id'].to_i)
  @cities = Country.show_cities_visited(params['id'].to_i)
  erb(:"cities/index")
end

post '/visited/:id/delete' do
  Country.remove(params['id'])
  redirect to("/visited")
end

post '/unvisited/:id/delete' do
  Country.remove(params['id'])
  redirect to("/unvisited")
end

get '/unvisited' do
  @name = "unvisited"
  @countries = Country.unvisited()
  erb(:'countries/index')
end

get '/unvisited/:id' do
  @status = "unvisited"
  @country = Country.find(params['id'].to_i)
  @cities = Country.show_cities_unvisited(params['id'].to_i)
  erb(:"cities/index")
end

get '/cities/new/:id' do
  @country = Country.find(params[:id])
  erb(:"cities/new")
end


post '/cities' do
  @city = City.new(params)
  @city.save()
  if @city.visited == "t" #"t"=true
    value = "visited"
  else
    value = "unvisited"
  end
  redirect to ("/#{value}/#{@city.country_id}")
end


post '/cities/:id/delete' do
  value = Country.is_visited(params['id'].to_i)
  City.remove(params['id'].to_i)
  redirect to("/#{value}/#{params['id']}")
end
