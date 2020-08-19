module Op::Posts
  class GetIpsAuthors < Trailblazer::Activity::Path
    step :model
    
    def model(ctx, **)
      sql = "select p.author_ip, string_agg(distinct u.login,  ', ') as logins "\
      "from posts p  left join users u ON u.id = p.user_id group by p.author_ip"

      ips_with_authors = ActiveRecord::Base.connection.execute(sql).to_a

      if ips_with_authors
        ctx[:model] = ips_with_authors.map do |model| 
          { 
            author_ip: model['author_ip'],
            logins: model['logins'].split(', ')
          }
        end
      else
        ctx[:model] = []
      end
    end
  end
end