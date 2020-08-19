module Op::Posts
  class New < Trailblazer::Activity::Path
    step :validate, Output(Trailblazer::Activity::Left, :failure) => End(:invalid)
    step :find_user, Output(Trailblazer::Activity::Left, :failure) => Id(:create_user)
    step :create_user, magnetic_to: nil, Output(Trailblazer::Activity::Right, :success) => Id(:create_post)
    step :create_post
    
    def validate(ctx, params:, **)
      validation = Validators::PostContract.new.call(params)
      validation.success? ? ctx[:params] = validation.to_h : ctx[:errors] = validation.errors.to_h
    end
    
    def find_user(ctx, params:, **)
      ctx[:user] = User.find_by_login(params[:login])
      ctx[:user] ? Trailblazer::Activity::Right : Trailblazer::Activity::Left
    end

    def create_user(ctx, params:, **)
      ctx[:user] = User.create(login: params[:login])
    end

    def create_post(ctx, params:, **)
      post_params =  params.slice(:title, :content, :author_ip).merge(user: ctx[:user])
      ctx[:model] = Post.create(post_params)
    end
  end
end