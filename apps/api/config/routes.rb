# Configure your routes here
# See: https://guides.hanamirb.org/routing/overview

get  '/posts/:id', to: 'posts#show'
post '/posts/new', to: 'posts#new'
post '/rates/new', to: 'rates#new'
get  '/posts', to: 'posts#index'
get  '/get_ips_authors', to: 'posts#get_ips_authors'

# ab -c 50 -n 10000 -f TLS1.2 -H "Accept-Encoding: gzip,deflate" https://pavelgyravel.tk/api/posts/200