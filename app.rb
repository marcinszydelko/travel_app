require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/cities_controller')
require_relative('controllers/countries_controller')
also_reload( './models/*' )


get '/' do
  erb( :index )
end
