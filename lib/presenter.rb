module ResponsePresenter
  def present(signal, ctx, presenter_klass)
    if signal.to_h[:semantic] == :success 
      self.body = {
        data: ctx[:model].instance_of?(Array)? ctx[:model].map{|el| presenter_klass.new(el)} : presenter_klass.new(ctx[:model])
      }.to_json
    else
      self.status = 422
      self.body = ErrorStruct.new(errors: ctx[:errors]).to_json
    end
  end
end