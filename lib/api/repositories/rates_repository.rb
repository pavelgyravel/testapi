class RatesRepository < Hanami::Repository
  associations do
    belongs_to :post
  end
end
