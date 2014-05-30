module GitmetricHelper 
	
	def index
  		start_date = Date.strptime('01-05-2013', '%d-%m-%Y')
		  end_date = Date.strptime('01-05-2014', '%d-%m-%Y')
  		@dfr = defect_find_rate 'publify', 'publify', start_date, end_date,'bug'
  		@bfr = bug_fix_rate 'publify', 'publify', start_date, end_date,'bug'
  		@fcr = feature_completion_ratio 'publify', 'publify', start_date, end_date,'feature'
  		@fi = feature_implemented 'publify', 'publify', start_date, end_date
  		date = Date.strptime('23-05-2014', '%d-%m-%Y')
  	
  		@cc = code_churn 'publify', 'publify', date, 5


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
      
      end

    end 


  	def defect_find_rate repo, user, start_date, end_date, label
  		search = Github::Search.new 
  		var = search.issues q: 'repo:' + user + '/' + repo +' label:'+label+' created:'+start_date.to_s+'..'+end_date.to_s

  		days = (end_date-start_date).to_i
  		dfr = (var.total_count.to_f/days.to_f)
  		
  		return dfr

  	end

  	def bug_fix_rate repo, user, start_date, end_date,label
  		search = Github::Search.new 
  		var = search.issues q: 'repo:' + user + '/' + repo +' label:'+label+' state:closed created:'+start_date.to_s+'..'+end_date.to_s

  		days = (end_date-start_date).to_i
  		bfr = (var.total_count.to_f/days.to_f)
  		
  		return bfr

  	end


  	def feature_completion_ratio repo, user, start_date, end_date,label
  		search = Github::Search.new 
  		var = search.issues q: 'repo:' + user + '/' + repo +' label:'+label+' state:closed created:'+start_date.to_s+'..'+end_date.to_s

  		days = (end_date-start_date).to_i
  		fcr = (var.total_count.to_f/days.to_f)
  		
  		return fcr

  	end

  	def feature_implemented repo, user, start_date, end_date
  		search = Github::Search.new 
  		var = search.issues q: 'repo:' + user + '/' + repo +' label:feature state:closed created:'+start_date.to_s+'..'+end_date.to_s
  		
  		return var.total_count.to_i

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

  		return addition_deletion_count/(week_count*7).to_f
  	end


	
end
