module Api
  module Controllers
    module Posts
      class Show
        include Api::Action

        def call(params)
          signal, (ctx, _) = Op::Posts::Show.(params: {id: params[:id].to_i})
          present(signal, ctx, PostStruct)
        end
      end
    end
  end
end
