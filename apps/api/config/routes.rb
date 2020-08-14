# Configure your routes here
# See: https://guides.hanamirb.org/routing/overview
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }

get  '/posts/:id', to: 'posts#show'
post '/posts/new', to: 'posts#new'
post '/rates/new', to: 'rates#new'
get  '/posts', to: 'posts#index'
get  '/get_ips_authors', to: 'posts#get_ips_authors'