module Api
  module Controllers
    module Posts
      class Show
        include Api::Action

        def call(params)
          signal, (ctx, _) = Op::Posts::Show.(params: {id: params[:id].to_i})
          self.format =  :json
          self.body = signal.to_h[:semantic] == :success ? ctx[:model].to_h.to_json : ctx[:errors].to_json 
        end
      end
    end
  end
end
