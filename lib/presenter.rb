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

  def present_v2(signal, ctx, presenter_klass)
    if signal.to_h[:semantic] == :success 
      self.body = if ctx[:model].instance_of?(Array)
        presenter_klass.for_collection.prepare(ctx[:model]).to_json
      else 
        presenter_klass.prepare(ctx[:model]).to_json
      end
    else
      self.status = 422
      self.body = ErrorRepresenter.prepare(Struct.new(errors: ctx[:errors])).to_json
    end
  end
end