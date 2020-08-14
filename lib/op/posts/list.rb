module Op::Posts
  class List < Trailblazer::Activity::Path
    step :validate, Output(Trailblazer::Activity::Left, :failure) => End(:invalid)
    step :find_rates
    
    def validate(ctx, params:, **)
      sch = Dry::Validation.Schema(Validators::BaseSchema) do
        required(:count).filled(:int?, gt?: 0, lteq?: 1000)
      end
      validation = sch.call(params)
      ctx[:errors] = validation.errors
      validation.success?
    end
    
    def find_rates(ctx, params:, **)
      ctx[:posts] = PostRepository.new.get_top(params[:count])
    end

  end
end