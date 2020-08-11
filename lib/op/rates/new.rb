module Op::Rates
  class New < Trailblazer::Activity::Path
    step :validate, Output(Trailblazer::Activity::Left, :failure) => End(:invalid)
    step :find_post, Output(Trailblazer::Activity::Left, :failure) => End(:invalid)
    step :create_rate
    
    def validate(ctx, params:, **)
      sch = Dry::Validation.Schema do
        required(:rate).filled(:int?, included_in?: [1,2,3,4,5])
        required(:post_id).filled(:int?, gt?: 0)
      end
      validation = sch.call(params)
      ctx[:errors] = validation.errors
      validation.success? 
    end
    
    def find_post(ctx, params:, **)
      ctx[:post] = PostRepository.new.find(params[:post_id])
      ctx[:errors] = {not_found: 'Post not found'} if !ctx[:post]
      ctx[:post] ? Trailblazer::Activity::Right : Trailblazer::Activity::Left
    end

    def create_rate(ctx, params:, **)
      ctx[:model] = PostRepository.new.update_rate(ctx[:post].id, params[:rate])
    end
  end
end