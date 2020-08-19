module Op::Posts
  class Show < Trailblazer::Activity::Path
    step :validate, Output(Trailblazer::Activity::Left, :failure) => End(:invalid)
    step :model, Output(Trailblazer::Activity::Left, :failure) => End(:invalid)
    
    def validate(ctx, params:, **)
      validation = Validators::PostShowContract.new.call(params)
      ctx[:errors] = validation.errors.to_h
      validation.success? 
    end
    
    def model(ctx, params:, **)
      ctx[:model] = Post.find(params[:id])
      ctx[:errors] = {not_found: 'Post not found'} if !ctx[:model] 
      ctx[:model] ? Trailblazer::Activity::Right : Trailblazer::Activity::Left
    end
  end
end