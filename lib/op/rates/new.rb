module Op::Rates
  class New < Trailblazer::Activity::Path
    step :validate, Output(Trailblazer::Activity::Left, :failure) => End(:invalid)
    step :find_post, Output(Trailblazer::Activity::Left, :failure) => End(:invalid)
    step :create_rate
    
    def validate(ctx, params:, **)
      validation = Validators::RateContract.new.call(params)
      ctx[:errors] = validation.errors.to_h
      validation.success? 
    end
    
    def find_post(ctx, params:, **)
      ctx[:model] = Post.joins(:user).select("posts.*, users.login").find_by(id: params[:post_id])
      ctx[:errors] = {not_found: 'Post not found'} if !ctx[:model]
      ctx[:model] ? Trailblazer::Activity::Right : Trailblazer::Activity::Left
    end

    def create_rate(ctx, params:, **)
      created_rate = Rate.create(rate: params[:rate], post: ctx[:model])
      avg_rate = Rate.where("post_id = :post_id and created_at <= :created_at", {post_id: ctx[:model].id, created_at: created_rate.created_at}).average(:rate)
      ctx[:model].update_attribute(:rate, avg_rate)
    end
  end
end