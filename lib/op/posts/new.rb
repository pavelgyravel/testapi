module Op::Posts
  class New < Trailblazer::Activity::Path
    step :validate, Output(Trailblazer::Activity::Left, :failure) => End(:invalid)
    step :find_user, Output(Trailblazer::Activity::Left, :failure) => Id(:create_user)
    step :create_user, magnetic_to: nil, Output(Trailblazer::Activity::Right, :success) => Id(:create_post)
    step :create_post
    
    def validate(ctx, params:, **)
      validation = Validators::PostSchema.call(params)
      ctx[:errors] = validation.errors
      validation.success?
    end
    
    def find_user(ctx, params:, **)
      ctx[:user] = UserRepository.new.find_by_login(params[:login])
      ctx[:user] ? Trailblazer::Activity::Right : Trailblazer::Activity::Left
    end

    def create_user(ctx, params:, **)
      ctx[:user] = UserRepository.new.create(login: params[:login])
    end

    def create_post(ctx, params:, **)
      post_params =  params.merge(user_id: ctx[:user].id)
      ctx[:model] = PostRepository.new.create(post_params)
    end
  end
end