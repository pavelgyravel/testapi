# class RatesRepository < Hanami::Repository
#   associations do
#     belongs_to :post
#   end

#   def find_with_posts(id)
#     aggregate(:post).where(id: id).map_to(Rates).one
#   end

#   def get_avg_rate post_id
#     rates.select{ float::avg(:rate).as(:avg_rate) }.where(post_id: post_id).order(nil).map.to_a.first[:avg_rate]
#   end
# end
