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
          
          self.format =  :json
          if signal.to_h[:semantic] == :success
            self.body = ctx[:post].to_json   
          else 
            self.body = ctx[:errors].to_json 
            self.status = 422
          end
          
          
        end
      end
    end
  end
end
