module Api
  module Controllers
    module Posts
      class New
        include Api::Action

        def call(params)
          op_params = {
            title: params[:title],
            content: params[:content],
            author_ip: params[:author_ip],
            login: params[:login]
          }

          signal, (ctx, _) = Op::Posts::New.(params: op_params)

          present(signal, ctx, PostStruct)
        end
      end
    end
  end
end
