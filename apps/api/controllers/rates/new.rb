module Api
  module Controllers
    module Rates
      class New
        include Api::Action

        def call(params)
          op_params = {
            post_id: params[:post_id],
            rate: params[:rate].to_i
          }
          
          signal, (ctx, _) = Op::Rates::New.(params: op_params)
          
          present(signal, ctx, PostStruct)
          
        end
      end
    end
  end
end
