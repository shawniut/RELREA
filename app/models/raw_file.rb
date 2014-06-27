class RawFile < ActiveRecord::Base
	serialize :file, JSON
	require 'rest_client'
	


	def jira

		project_key = "ABC"
		jql = "jql=project%20=%20RP%20AND%20issuetype%20=%20Bug%20AND%20status%20in%20(Resolved,%20Closed)"
		#url = URI.parse("http://api-user:api-user@releaseplanner.atlassian.net/rest/api/2/search?'maxResults=1&fields=status,resolved,created,updated,priority,project,issuetype&jql=project=RP")
		#url = "http://api-user:api-user@releaseplanner.atlassian.net/rest/api/2/search?'maxResults=1000&fields=status,created,updated,priority,project,issuetype&jql=project=RP"
		#url = "http://api-user:api-user@releaseplanner.atlassian.net/rest/api/2/search?'maxResults=1&fields=status,resolved,created,updated,priority,project,issuetype&jql=project=RP"
		#jira_url = "https://shawniut:shawonma151@api.github.com/repos/expertdecisions/rp2/tags?per_page=1000"
		# latest 5 issues from a project with 'Major' priority

		#url = "http://api-user:api-user@releaseplanner.atlassian.net/rest/api/2/search?maxResults=1000&jql=project%20=%20RP%20AND%20issuetype%20=%20Bug%20AND%20status%20in%20(Open,%20\"In%20Progress\",%20Reopened,%20Resolved,%20Closed)"
		url = 'https://api-user:api-user@releaseplanner.atlassian.net/rest/api/2/search?maxResults=1000&jql=project%20%3D%20RP%20AND%20issuetype%20%3D%20%22New%20Feature%22%20AND%20priority%20in%20(Minor%2C%20Trivial)'
		puts url.to_s
		response = RestClient.get(url)
		if(response.code != 200)
  			raise "Error with the http request!"
		end

		data = JSON.parse(response.body)
		
		count = 0;
		data['issues'].each do |issue|
			#Summary: #{issue['fields']['summary']
  			puts "Key: #{issue['key']}"
  			puts "status: #{issue['fields']['status']['name']}"
  			puts "created: #{issue['fields']['created']}"
  			puts "updated: #{issue['fields']['updated']}"
  			puts "updated: #{issue['fields']['resolved']}"
  			puts "priority: #{issue['fields']['priority']['name']}"
  			puts "project: #{issue['fields']['project']['name']}"
  			puts "type: #{issue['fields']['issuetype']['name']}"
  			count +=1
		end
		puts "count#{count}"
	end

	def data

		Dataservice::Metric.where(:name=>'Features Implemented', :source=>'Github')[0].update_attributes(:code=>'FI')
		Dataservice::Metric.where(:name=>'Feature completion rate', :source=>'Github')[0].update_attributes(:code=>'FCR')
		Dataservice::Metric.where(:name => "Build success rate ", :source => "Travis-CI")[0].update_attributes(:code=>'BSR')
		Dataservice::Metric.where(:name => "Code churn rate", :source => "Github")[0].update_attributes(:code=>'CCR')
		Dataservice::Metric.where(:name => "Defect find rate", :source => "Github")[0].update_attributes(:code=>'DFR')
		Dataservice::Metric.where(:name => "Bug fix rate", :source => "Github")[0].update_attributes(:code=>'BFR')
		Dataservice::Metric.where(:name => "Pull-request Completion Rate", :source => "Github")[0].update_attributes(:code=>'PCR')
		Dataservice::Metric.where(:name =>"Defect density", :source => "Github")[0].update_attributes(:code=>'DD')

		Dataservice::Metric.where(:name =>"Bug fix rate", :source => "JIRA")[0].update_attributes(:code=>'BFR')
		Dataservice::Metric.where(:name =>"Defect find rate", :source => "JIRA")[0].update_attributes(:code=>'DFR')
		Dataservice::Metric.where(:name => "Feature completion rate", :source => "JIRA")[0].update_attributes(:code=>'FCR')
		Dataservice::Metric.where(:name => "Improvement Implemented", :source => "JIRA")[0].update_attributes(:code=>'II')
		Dataservice::Metric.where(:name => "Features Implemented", :source => "JIRA")[0].update_attributes(:code=>'FI')

		Dataservice::Metric.where(:name => "High priority Features implementation ratio", :source => "JIRA")[0].update_attributes(:code=>'HP-FIR')
		Dataservice::Metric.where(:name => "Low priority Features Implementation ratio", :source => "JIRA")[0].update_attributes(:code=>'LP-FIR')

		Dataservice::Metric.where(:name => "High priority improvement implementation ratio", :source => "JIRA")[0].update_attributes(:code=>'HP-IIR')
		Dataservice::Metric.where(:name => "Low priority improvement implementation ratio", :source => "JIRA")[0].update_attributes(:code=>'LP-IIR')
		Dataservice::Metric.where(:name => "Improvement implementation ratio", :source => "JIRA")[0].update_attributes(:code=>'IIR')
	end
end
