module GitmetricHelper 
	require 'open-uri'
  require 'json'

	def index
  		start_date = Date.strptime('01-05-2013', '%d-%m-%Y')
		  end_date = Date.strptime('01-05-2014', '%d-%m-%Y')
  		@dfr = defect_find_rate 'publify', 'publify', start_date, end_date,'bug'
  		@bfr = bug_fix_rate 'publify', 'publify', start_date, end_date,'bug'
  		@fcr = feature_completion_ratio 'publify', 'publify', start_date, end_date,'feature'
  		@fi = feature_implemented 'publify', 'publify', start_date, end_date
  		
      date = Date.strptime('23-05-2014', '%d-%m-%Y')
  	
  		@cc = code_churn 'publify', 'publify', date, 7


  	end

    def get_git_metric_value repo, user, start_date, end_date, metric_name

      if metric_name == "Feature completion rate"
        return feature_completion_ratio repo, user, start_date, end_date,'feature'
       elsif metric_name == "Features Implemented"
         return feature_implemented repo, user, start_date, end_date

      elsif metric_name == "Code churn rate"
        return code_churn repo, user, end_date, 5

      elsif metric_name == "Defect find rate"
        return defect_find_rate repo, user, start_date, end_date,'bug'

       elsif metric_name == "Bug fix rate"
        return bug_fix_rate repo, user, start_date, end_date,'bug'
       
       elsif metric_name == "Pull-request Completion Rate"
        return get_pull_request_completion_rate repo, user, start_date, end_date
    
      end

    end 


  	def defect_find_rate repo, user, start_date, end_date, label
  		search = Github::Search.new 
  		var = search.issues q: 'repo:' + user + '/' + repo +' label:'+label+' created:'+start_date.to_s+'..'+end_date.to_s

  		days = (end_date-start_date).to_i
  		dfr = (var.total_count.to_f/days.to_f)
  		
  		return dfr.round(2)

  	end

  	def bug_fix_rate repo, user, start_date, end_date,label
  		search = Github::Search.new 
  		var = search.issues q: 'repo:' + user + '/' + repo +' label:'+label+' state:closed created:'+start_date.to_s+'..'+end_date.to_s

  		days = (end_date-start_date).to_i
  		bfr = (var.total_count.to_f/days.to_f)
  		
  		return bfr.round(2)

  	end


  	def feature_completion_ratio repo, user, start_date, end_date,label
  		search = Github::Search.new 
  		var = search.issues q: 'repo:' + user + '/' + repo +' label:'+label+' state:closed updated:'+start_date.to_s+'..'+end_date.to_s

  		days = (end_date-start_date).to_i
  		fcr = (var.total_count.to_f/days.to_f)
  		
  		return fcr.round(2)

  	end

  	def feature_implemented repo, user, start_date, end_date
  		search = Github::Search.new 
  		var = search.issues q: 'repo:' + user + '/' + repo +' label:feature state:closed updated:'+start_date.to_s+'..'+end_date.to_s
  		
  		return var.total_count.to_f

  	end

  	def code_churn repo, user, end_date, week_count

  		activity = Github::Repos.new( user: user, repo: repo).stats.code_frequency

  		count=0;
  		addition_deletion_count=0.0
  		objArray = JSON.parse(activity.to_s)
  		objArray.reverse.each do |w|
  			date = Time.at(w[0]).to_date
  			if end_date >= date && count < week_count
  				addition_deletion_count+=w[1].to_f
  				addition_deletion_count-=w[2].to_f
  				count+=1
  			end

  		end

  		return (addition_deletion_count/(week_count*7).to_f).round(2)
  	end

    def get_releases repo, user, project

      releases = []
      releases_data = activity = Github.new.repos.releases.list user, repo
      start_date = project.info.start_date

      releases_data.reverse_each do |r|
        release = Release.new
        release.name = r.tag_name
        release.date = r.published_at.to_date
        release.start_date = start_date
        releases << release
        start_date = release.date + 1.days
      end

        release = Release.new # this is for next release
        release.name = "next"
        release.start_date = start_date
        release.date = Time.now.to_date

        releases << release

      return releases
    end

    def get_pull_request_completion_rate repo, user, start_date, end_date
      #output = open(request_uri, {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE})
      start_date = "2013-01-04".to_date
      end_date = "2014-05-04".to_date
      pulls  = JSON.parse(File.read("C:\\Users\\Jason\\AppData\\Local\\Temp\\open-uri20140606-4400-c8bwfg"))


      total_requested = 0
      total_completed = 0

      pulls.each do |p|

        if p['created_at'].to_date >= start_date and p['created_at'].to_date <= end_date
          total_requested +=1
        end
        
        if p['state'] == "closed" and p['closed_at'].to_date >= start_date and p['closed_at'].to_date <= end_date
          total_completed +=1
        end
      end

      # puts "total_requested: #{total_requested}"
      # puts "total_requested: #{total_completed}"
      # puts "Rate: #{(total_completed.to_f/total_requested.to_f)*100}"
      return (total_completed.to_f/total_requested.to_f)*100

    end
	
end
