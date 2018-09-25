require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )

require_relative( './models/pizza_order' )
also_reload( './models/*' )

# index route to read all the pizza orders
get '/pizza-orders' do
  @orders = PizzaOrder.all()
  erb(:index)
end

# new pizza route. This needs to be before the /pizza-orders/:id otherwise it will always take us to that route and this .../new route would never be called. So order of the GET statements is important!
get '/pizza-orders/new' do
  erb(:new)
end

# create - make a pizza_order
post '/pizza-orders' do
  @order = PizzaOrder.new(params)
  @order.save
  erb(:create)
end

# delete pizza
post '/pizza-orders/:id/delete' do
  # @order = PizzaOrder.delete_by_id(params[:id])
  @order = PizzaOrder.find(params[:id])
  @order.delete()
  # erb(:delete)
  redirect '/pizza-orders'
end

#edit pizza - brings back the existing details in a form
get '/pizza-orders/:id/edit' do
  @order = PizzaOrder.find(params[:id])
  erb(:edit)
end

#update pizza - push the changes from edit into the database
post '/pizza-orders/:id' do
  @order = PizzaOrder.new(params)
  @order.update()
  # erb(:update)
  redirect '/pizza-orders'
end

# show one pizza based on what id is passed in the URL
get '/pizza-orders/:id' do
  @order = PizzaOrder.find(params[:id])
  erb(:show)
end
