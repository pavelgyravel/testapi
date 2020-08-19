require 'faker'
require 'net/http'
require 'uri'
require 'json'
require 'rake'
require 'rake-progressbar'



puts "Dummy data creating started.."
    
    ips_count = 50
    authors_count = 100
    posts_count = 2000
    rates_count = 100
    req_count=0


    domain =  'http://localhost:2300'
    bar = RakeProgressbar.new( rates_count + posts_count)
    starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    ips = Array.new(ips_count).map{ Faker::Internet.ip_v4_address }
    authors = Array.new(authors_count).map{ "#{Faker::Name.first_name}_#{Faker::Name.last_name}".downcase }
    posts_ids = []

    uri = URI.parse("#{domain}/api/posts/new")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    req_options = {
      use_ssl: uri.scheme == "https",
    }
    posts_count.times do |i|
      request.body = JSON.dump({
        "title": Faker::Lorem.word,
        "content": Faker::Lorem.sentence(word_count: rand(100)),
        "author_ip": ips.sample,
        "login": authors.sample
      })
      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        response = http.request(request)
        posts_ids << JSON.parse(response.body).dig('data','id')
      end
      req_count+=1
      bar.inc
    end

    ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    elapsed = ending - starting

    puts "Creating posts done in #{elapsed}seconds"
    puts "="*50
    puts "Start creating rates"

    rate_starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    posts_to_rate = Array.new(rates_count).map{posts_ids.sample}
    posts_to_rate.each do |post_id|
      rand(10).times do
        
        uri = URI.parse("#{domain}/api/rates/new")
        request = Net::HTTP::Post.new(uri)
        request.content_type = "application/json"
        request.body = JSON.dump({
          "post_id": post_id,
          "rate": Faker::Number.between(from: 1, to: 5)
        })

        req_options = {
          use_ssl: uri.scheme == "https",
        }

        response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
          response = http.request(request)
          puts response
        end
        req_count+=1
      end
      bar.inc
    end
    bar.finished

    rate_endind = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    puts "Creating rates done in #{rate_endind -rate_starting}seconds"
    puts "="*50
    puts "Total execution tine is #{rate_endind - starting}seconds"
    puts "Avg rps is #{(rate_endind - starting)/req_count}"