# Configure your routes here
# See: https://guides.hanamirb.org/routing/overview
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
get '/posts/:id', to: 'posts#show'
post '/posts/new', to: 'posts#new'
post '/rates/new', to: 'rates#new'
