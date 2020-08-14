module Api
  module Controllers
    module Posts
      class GetIpsAuthors
        include Api::Action

        def call(params)
          signal, (ctx, _) = Op::Posts::GetIpsAuthors.(params:{})
          if signal.to_h[:semantic] == :success
            self.body = ctx[:result].to_json   
          else 
            self.body = ctx[:errors].to_json 
            self.status = 422
          end
        end
      end
    end
  end
end
