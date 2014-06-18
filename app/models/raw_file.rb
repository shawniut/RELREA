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
end
