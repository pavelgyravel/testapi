require 'faker'
require 'net/http'
require 'uri'
require 'json'
require 'rake'
require 'rake-progressbar'
require 'httparty'


puts "Dummy data creating started.."
    
threads_count = 20

ips_count = 50
authors_count = 100
posts_count = 5000
rates_count = 500
retes_per_post = 5
req_count = 0


domain =  'http://64.225.75.221'

bar = RakeProgressbar.new( posts_count + (rates_count * retes_per_post))
starttime = Process.clock_gettime(Process::CLOCK_MONOTONIC)
ips = Array.new(ips_count).map{ Faker::Internet.ip_v4_address }
authors = Array.new(authors_count).map{ "#{Faker::Name.first_name}_#{Faker::Name.last_name}".downcase }
posts_ids = []

threads = []
threads_count.times do 
  threads << Thread.new do
    (posts_count/threads_count).times do |i|
      response = HTTParty.post("#{domain}/api/posts/new", body: {
        "title": Faker::Lorem.word,
        "content": Faker::Lorem.sentence(word_count: rand(100)),
        "author_ip": ips.sample,
        "login": authors.sample
      })

      posts_ids << JSON.parse(response.body).dig('data','id')

      req_count+=1
      bar.inc
    end
  end
end

threads.each(&:join)

posts_to_rate = Array.new(rates_count).map{posts_ids.sample}
threads = []
posts_to_rate.each_slice(rates_count/threads_count).to_a.each do |posts|
  threads << Thread.new do
    posts.each do |post_id|
      retes_per_post.times do 
        response = HTTParty.post("#{domain}/api/rates/new", body: {
          "post_id": post_id,
          "rate": Faker::Number.between(from: 1, to: 5)
        })

        req_count+=1
        bar.inc
      end
    end
  end
end

threads.each(&:join)

bar.finished

all_requests_time = Process.clock_gettime(Process::CLOCK_MONOTONIC) - starttime

puts "Avg request time #{all_requests_time*1000/req_count} ms"