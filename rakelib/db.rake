require 'faker'
require 'net/http'
require 'uri'
require 'json'

namespace :db do
  desc 'Creates initiad data'
  task :seed do
    # 200k Done in 1777.9301319997758seconds
    starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    ips = Array.new(50).map{ Faker::Internet.ip_v4_address }
    authors = Array.new(100).map{ "#{Faker::Name.first_name}_#{Faker::Name.last_name}".downcase }

    
    1000.times do
      uri = URI.parse("http://localhost:2300/api/posts")
      request = Net::HTTP::Post.new(uri)
      request.content_type = "application/json"
      request.body = JSON.dump({
        "title": Faker::Lorem.word,
        "content": Faker::Lorem.sentence(word_count: rand(100)),
        "author_ip": ips.sample,
        "login": authors.sample
      })

      req_options = {
        use_ssl: uri.scheme == "https",
      }

      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
    end
  


    ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    elapsed = ending - starting

    puts "Done in #{elapsed}seconds"

  end

  task :create_random_rates do
    ids = PostRepository.new.get_ids
    
    posts_to_rate = Array.new(200).map{ids.sample.id}
    
    posts_to_rate.each do |post_id|
      rand(1000).times do
        RatesRepository.new.create(post_id: post_id, rate: [1,2,3,4,5].sample)
      end
    end
  end
end