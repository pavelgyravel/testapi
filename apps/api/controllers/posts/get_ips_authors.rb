module Api
  module Controllers
    module Posts
      class GetIpsAuthors
        include Api::Action

        def call(params)
          signal, (ctx, _) = Op::Posts::GetIpsAuthors.(params:{})

          present(signal, ctx, IpAurhorsStruct)
        end
      end
    end
  end
end
