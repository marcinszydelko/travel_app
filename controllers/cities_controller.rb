require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/city.rb' )
require_relative( '../models/country.rb' )
also_reload( '../models/*' )


get '/cities/new/:id' do
  @country = Country.find(params['id'])
  erb(:"cities/new")
end

post '/cities' do
  @city = City.new(params)
  @city.save()
  if @city.visited == "t"
    value = "visited"
  else
    value = "unvisited"
  end
  redirect to ("/#{value}/#{@city.country_id}")
end


post '/cities/:id/delete' do
  @country = City.find(params['id'])
  if @country.visited == "t"
    value = "visited"
  else
    value = "unvisited"
  end
  City.remove(params['id'].to_i)
  redirect to("/#{value}/#{@country.country_id}")
end


get '/cities/:id/edit' do
  @city = City.find(params['id'])
  @country = Country.find(@city.country_id)
  erb(:"cities/edit")
end

post '/cities/:id' do
  @city = City.find(params['id'])
  @city.name = params['name']
  @city.update()
  if @city.visited == "t"
    value = "visited"
  else
    value = "unvisited"
  end
  redirect to ("/#{value}/#{@city.country_id}")
end
