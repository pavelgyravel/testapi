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
end
