module Api
  module Controllers
    module Posts
      class Show
        include Api::Action

        def call(params)
          signal, (ctx, _) = Op::Posts::Show.(params: {id: params[:id].to_i})
          params[:v2] ? present_v2(signal, ctx, PostRepresenter) : present(signal, ctx, PostStruct)
        end
      end
    end
  end
end
