module ResponsePresenter
  def present(signal, ctx, presenter_klass)
    if signal.to_h[:semantic] == :success 
      data = if ctx[:model].instance_of?(Array)
        ctx[:model]
        # ctx[:model].map{|el| presenter_klass.new(el)} 
      else 
        ctx[:model]
        # presenter_klass.new(ctx[:model])
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