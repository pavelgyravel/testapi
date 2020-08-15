module Api
  module Controllers
    module Posts
      class Index
        include Api::Action

        def call(params)
          op_params = {}
          op_params[:count] = params[:count].to_i if params[:count]
          signal, (ctx, _) = Op::Posts::List.(params: op_params)

          present(signal, ctx, PostStruct)

        end
      end
    end
  end
end
