module ResponsePresenter
  def present(signal, ctx, presenter_klass)
    if signal.to_h[:semantic] == :success 
      data = if ctx[:model].instance_of?(Array)
        ctx[:model].map{|el| 
          obj = el.instance_of?(Hash) ? el : el.attributes.symbolize_keys
          presenter_klass.new(obj)
        } 
      else 
        presenter_klass.new(ctx[:model].attributes.symbolize_keys)
      end
      self.body = {
        data: data
      }.to_json
    else
      self.status = 422
      self.body = ErrorStruct.new(errors: ctx[:errors]).to_json
    end
  end
end