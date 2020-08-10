class UserRepository < Hanami::Repository
    associations do
        has_many :posts
    end

    def find_with_posts(id)
        aggregate(:posts).where(id: id).as(User).one
    end

    def find_by_login(login)
        users.where(login: login).to_a.first
    end
end
