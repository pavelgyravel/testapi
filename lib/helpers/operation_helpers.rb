module OperationHelpers
  def add_error(ctx, attr, error)
    ctx[:errors] = ctx[:errors].nil? ? {} : ctx[:errors]
    ctx[:errors][attr] ||= []
    ctx[:errors][attr] << error
    ctx[:errors][attr].flatten!

    # Hacky return false to route operation to :failure track
    # if step is ending on add_error
    false
  end

  def handle_validation_errors(ctx)
    return true if ctx[:validation_result].success?

    errors = ctx[:validation_result].errors
    
    errors.each do |attr, messages|
      messages.each do |message|
        add_error(ctx, attr, message)
      end
      
    end
    false
  end
end