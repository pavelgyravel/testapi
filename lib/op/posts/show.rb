module Op::Posts
  class Show < Trailblazer::Activity::Path
    step :validate, Output(Trailblazer::Activity::Left, :failure) => End(:invalid)
    step :model, Output(Trailblazer::Activity::Left, :failure) => End(:invalid)
    
    def validate(ctx, params:, **)
      sch = Dry::Validation.Schema do
        required(:id).filled(:int?, gt?: 0)
      end
      validation = sch.call(params)
      ctx[:errors] = validation.errors
      validation.success? 
    end
    
    def model(ctx, params:, **)
      ctx[:model] = PostRepository.new.find(params[:id])
      if !ctx[:model] 
        ctx[:errors] = {not_found: 'Post not found'}
        false
      else 
        true
      end
    end
  end
end