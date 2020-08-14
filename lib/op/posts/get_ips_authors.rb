module Op::Posts
  class GetIpsAuthors < Trailblazer::Activity::Path
    step :model
    
    def model(ctx, **)
      ips_with_authors = PostRepository.new.get_ips_with_authors

      if ips_with_authors
        ctx[:result] = ips_with_authors.map do |model| 
          { model[:author_ip] => model[:logins].split(', ')}
        end
      else
        ctx[:result] = []
      end
    end
  end
end