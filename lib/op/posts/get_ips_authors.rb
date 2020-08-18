module Op::Posts
  class GetIpsAuthors < Trailblazer::Activity::Path
    step :model
    
    def model(ctx, **)
      ips_with_authors = PostRepository.new.get_ips_with_authors

      if ips_with_authors
        ctx[:model] = ips_with_authors.map do |model| 
          { author_ip: model[:author_ip],
            logins: model[:logins].split(', ')
          }
        end
      else
        ctx[:model] = []
      end
    end
  end
end