class PostRepository < Hanami::Repository
  associations do
    belongs_to :user
  end

  associations do
    has_many :rates
  end

  def find_with_rate(id)
    aggregate(:posts).where(id: id).as(Rate).one
  end

  def get_ids
    posts.select(:id).to_a
  end

  def update_rate post_id, rate
    transaction do
      RatesRepository.new.create(post_id: post_id, rate: rate)
      avg_rate = RatesRepository.new.get_avg_rate(post_id)
      update(post_id, rate: avg_rate)
    end
  end
end
