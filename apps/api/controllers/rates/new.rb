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
          
          self.format =  :json
          
          if signal.to_h[:semantic] == :success
            self.body = ctx[:model].to_h.to_json   
          else 
            self.body = ctx[:errors].to_json 
            self.status = 422
          end
        end
      end
    end
  end
end
