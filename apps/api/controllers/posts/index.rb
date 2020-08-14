module Api
  module Controllers
    module Posts
      class Index
        include Api::Action

        def call(params)
          op_params = {}
          op_params[:count] = params[:count].to_i if params[:count]
          signal, (ctx, _) = Op::Posts::List.(params: op_params)
          if signal.to_h[:semantic] == :success
            self.body = ctx[:posts].to_json   
          else 
            self.body = ctx[:errors].to_json 
            self.status = 422
          end
        end
      end
    end
  end
end
