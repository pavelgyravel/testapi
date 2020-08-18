# class PostRepository < Hanami::Repository
#   associations do
#     belongs_to :user
#   end

#   associations do
#     has_many :rates
#   end

#   def find_with_rate(id)
#     aggregate(:posts).where(id: id).as(Rate).one
#   end

#   def get_ids
#     posts.select(:id).to_a
#   end

#   def update_rate post_id, rate
#     transaction do
#       posts.read("select id, rate from posts where id=#{post_id} for update").map.to_a
#       RatesRepository.new.create(post_id: post_id, rate: rate)
#       update(post_id, rate: RatesRepository.new.get_avg_rate(post_id) )
#     end
#   end

#   def get_top count
#     posts.order { rate.desc }.limit(count).map.to_a
#   end

#   def get_ips_with_authors
#     posts.read("select p.author_ip, string_agg(distinct u.login,  ', ') as logins from posts p  left join users u ON u.id = p.user_id group by p.author_ip").map.to_a
#   end
# end
