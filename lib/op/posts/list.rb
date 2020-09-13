module Op::Posts
  class List < Trailblazer::Activity::Path
    step :validate, Output(Trailblazer::Activity::Left, :failure) => End(:invalid)
    step :find_rates
    
    def validate(ctx, params:, **)
      
      validation = Validators::PostListContract.new.call(params)
      ctx[:errors] = validation.errors.to_h
      validation.success?
    end
    
    def find_rates(ctx, params:, **)
      ctx[:model] = Post.order(rate: :desc).limit(params[:count]).to_a
    end

  end
end