module TestHelper
	def self.issue
		@issues = Github::Issues.new 
  		@var = @issues.list user: 'publify', repo: 'publify', state: 'open'
  		
  		
  		@var.each do |i|
  			puts i.name
  		end
	end
end
