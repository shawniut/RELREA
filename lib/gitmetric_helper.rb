module GitmetricHelper 
	require 'open-uri'
  require 'json'
  require 'rest_client'

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

    def get_git_metric_value repo, user, start_date, end_date, rattribute, project

      if rattribute.metric.name == "Feature completion rate" and project.jira == nil
        return feature_completion_ratio repo, user, start_date, end_date,rattribute.label, rattribute.raw_file.file
      
      elsif rattribute.metric.name == "Feature completion rate" and project.jira != nil
         return feature_completion_ratio_jira repo, user, start_date, end_date, rattribute.label, rattribute.raw_file.file
      
      elsif rattribute.metric.name == "Features Implemented" and project.jira == nil
         return feature_implemented repo, user, start_date, end_date, rattribute.label, rattribute.raw_file.file

      elsif rattribute.metric.name == "Features Implemented" and project.jira != nil
         return feature_implemented_jira repo, user, start_date, end_date, rattribute.label, rattribute.raw_file.file

      elsif rattribute.metric.name == "Improvement Implemented" and project.jira != nil
         return feature_implemented_jira repo, user, start_date, end_date, rattribute.label, rattribute.raw_file.file

      elsif rattribute.metric.name == "Code churn rate" 
        return code_churn repo, user, end_date, 2, rattribute.raw_file.file

      elsif rattribute.metric.name == "Defect find rate" and project.jira == nil
        return defect_find_rate repo, user, start_date, end_date,rattribute.label,rattribute.raw_file.file

      elsif rattribute.metric.name == "Defect find rate" and project.jira != nil
        return defect_find_rate_jira repo, user, start_date, end_date,rattribute.label,rattribute.raw_file.file

      elsif rattribute.metric.name == "Bug fix rate" and project.jira == nil
        return bug_fix_rate repo, user, start_date, end_date,rattribute.label,rattribute.raw_file.file
      
      elsif rattribute.metric.name == "Bug fix rate" and project.jira != nil
        return bug_fix_rate_jira repo, user, start_date, end_date,rattribute.label,rattribute.raw_file.file
      
      elsif rattribute.metric.name == "Pull-request Completion Rate"
        return get_pull_request_completion_rate repo, user, start_date, end_date, rattribute.raw_file.file
      elsif rattribute.metric.name == "Defect density"
        return get_defect_density repo, user, start_date, end_date, rattribute.raw_file.file, project
      end

    end 



  	def defect_find_rate repo, user, start_date, end_date, label, issues
  		days = (end_date-start_date).to_i

      total_count = 0
     
      issues["items"].each do |i|
       created_at = i["created_at"].to_date
        if created_at >=(end_date-30.days) and created_at <= end_date
           total_count+=1
        end
      end

  		dfr = (total_count.to_f/30.0)
  		
  		return dfr.round(2)

  	end

    def defect_find_rate_jira repo, user, start_date, end_date, label, issues
      days = (end_date-start_date).to_i

      total_count = 0
     
      issues["issues"].each do |issue|
        created_at = issue['fields']['created'].to_date
        issue_type = issue['fields']['issuetype']['name']
        state = issue['fields']['status']['name'] 
        if created_at >=(end_date-30.days) and created_at <= end_date
           total_count+=1
        end
      end

      dfr = (total_count.to_f/30.0)
      
      return dfr.round(2)
    end

    def get_defect_density repo, user, start_date, end_date, data, project

      code_churn = 0.0
      defects_count = 0.0
      days = (end_date-start_date).to_i
      project.rattributes.each do |r|
        if r.metric.name == "Code churn rate"
          logger.debug "shawn"
          code_churn = (r.values.where(:start_date=>start_date, :end_date=>end_date)[0].mvalue)*days
        end
        if r.metric.name == "Defect find rate"
          defects_count = (r.values.where(:start_date=>start_date, :end_date=>end_date)[0].mvalue)*days
        end
      end 
      logger.debug "Code churn:#{code_churn}"
      logger.debug "defects count:#{defects_count}"
      if(code_churn == 0)
        return 0
      else
        return ((defects_count/code_churn)*1000).round(3)
      end
    end

  	def bug_fix_rate repo, user, start_date, end_date,label,issues
       total_count = 0
       issues["items"].each do |i|
         updated_at = i["updated_at"].to_date
        if updated_at >=(end_date-30.days) and updated_at <= end_date and i["state"]=="closed"
           total_count+=1
        end
      end

  		days = (end_date-start_date).to_i
  		bfr = (total_count.to_f/30.0)
  		
  		return bfr.round(2)

  	end

      def bug_fix_rate_jira repo, user, start_date, end_date,label,issues

       #logger.debug "Shawn2#{issues["issue"]}"
       total_count = 0
       issues["issues"].each do |issue|
          updated_at = issue['fields']['updated'].to_date
          issue_type = issue['fields']['issuetype']['name']
          state = issue['fields']['status']['name'] 
          if updated_at >=(end_date-30.days) and updated_at <= end_date
             total_count+=1
          end
      end

      days = (end_date-start_date).to_i
      bfr = (total_count.to_f/30.0)
      
      return bfr.round(2)

    end


  	def feature_completion_ratio repo, user, start_date, end_date,label, issues
  		 total_count = 0
       issues["items"].each do |i|
         updated_at = i["updated_at"].to_date
        if updated_at >=start_date and updated_at <= end_date and i["state"]=="closed" 
           total_count+=1
        end
      end

  		days = (end_date-start_date).to_i
  		fcr = (total_count.to_f/days.to_f)
  		
  		return fcr.round(2)

  	end

    def feature_completion_ratio_jira repo, user, start_date, end_date,label, issues
       total_count = 0
        issues["issues"].each do |issue|
          updated_at = issue['fields']['updated'].to_date
          issue_type = issue['fields']['issuetype']['name']
          state = issue['fields']['status']['name'] 
          if updated_at >=start_date and updated_at <= end_date
             total_count+=1
          end
       end

      days = (end_date-start_date).to_i
      fcr = (total_count.to_f/days.to_f)
      
      return fcr.round(2)

    end

  	def feature_implemented repo, user, start_date, end_date, label, issues
  		total_count = 0
       issues["items"].each do |i|
         updated_at = i["updated_at"].to_date
        if updated_at >=start_date and updated_at <= end_date 
           total_count+=1
        end
      end
  		
  		return total_count.to_f

  	end

    def feature_implemented_jira repo, user, start_date, end_date, label, issues
      total_count = 0
       issues["issues"].each do |issue|
          updated_at = issue['fields']['updated'].to_date
          issue_type = issue['fields']['issuetype']['name']
          state = issue['fields']['status']['name'] 
          if updated_at >=start_date and updated_at <= end_date 
             total_count+=1
          end
       end
      
      return total_count.to_f

    end

  	def code_churn repo, user, end_date, week_count, data
  		count=0;
  		addition_deletion_count=0.0
  		data.reverse.each do |w|
  			date = Time.at(w[0]).to_date
  			if date >=(end_date-30.days) and date <= end_date
  				addition_deletion_count+=w[1].to_f
  				addition_deletion_count-=w[2].to_f
  				count+=1
  			end

  		end

  		return (addition_deletion_count/30).round(2)
  	end

    def get_releases repo, user, project

      releases = []
      if(project.info.is_private == false)
        releases_data = JSON.parse(open("https://api.github.com/repos/"+user+"/"+repo+"/tags?per_page=1000", {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}).read)
      else
        url = "https://"+project.username+":"+project.password+"@api.github.com/repos/"+user+"/"+repo+"/tags?per_page=1000"
        logger.debug url
        releases_data = JSON.parse(RestClient.get(url).body)
      end
      
      four_releases = [] #taking first four releases
      count = 1
      releases_data.each do |r|
        if count <=4
          four_releases <<r
        end
         count +=1
      end

      start_date = project.info.start_date

      four_releases.reverse_each do |r|
          release_date = (Github.new.repos.commits.get user, repo, r["commit"]["sha"]).commit.author.date
          release = Release.new
          release.name = r["name"]
          release.date = release_date
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

    def get_pull_request_completion_rate repo, user, start_date, end_date, pulls

      total_requested = 0.0
      total_completed = 0.0

      pulls.each do |p|

        if p['created_at'].to_date >= start_date and p['created_at'].to_date <= end_date
          total_requested +=1
        end
        
        if p['state'] == "closed" and p['closed_at'].to_date >= start_date and p['closed_at'].to_date <= end_date
          total_completed +=1
        end
      end

      if total_completed == 0
        return 0.0
      else
        return ((total_completed.to_f/total_requested.to_f)*100).round(2)
      end

    end


	
end
