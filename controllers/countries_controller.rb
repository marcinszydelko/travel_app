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

get '/unvisited/:id/edit' do
  @status = "unvisited"
  @country = Country.find(params['id'])
  erb(:"countries/edit")
end

post '/unvisited/:id' do
  @country = Country.find(params['id'])
  @country.name = params['name']
  @country.visited = params['visited']
  @country.update()
  redirect to ("/unvisited")
end

get '/visited/:id/edit' do
  @status = "visited"
  @country = Country.find(params['id'])
  erb(:"countries/edit")
end

post '/visited/:id' do
  @country = Country.find(params['id'])
  @country.name = params['name']
  @country.visited = params['visited']
  @country.update()
  redirect to ("/visited")
end
