# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Dataservice::Metric.create :name => "Feature completion rate", :source => "Github", :dimension => "Implementation"
Dataservice::Metric.create :name => "Features Implemented", :source => "Github", :dimension => "Implementation"
Dataservice::Metric.create :name => "Build success rate ", :source => "Travis-CI", :dimension => "Implementation"
Dataservice::Metric.create :name => "Code churn rate", :source => "Github", :dimension => "Testing"
Dataservice::Metric.create :name => "Defect find rate", :source => "Github", :dimension => "Testing"
Dataservice::Metric.create :name => "Bug fix rate", :source => "Github", :dimension => "Testing"
Dataservice::Metric.create :name => "Pull-request Completion Rate", :source => "Github", :dimension => "Testing"
Dataservice::Metric.create :name => "Defect density", :source => "Github", :dimension => "Testing"

Dataservice::Metric.create :name => "Bug fix rate", :source => "JIRA", :dimension => "Testing"
Dataservice::Metric.create :name => "Defect find rate", :source => "JIRA", :dimension => "Testing"
Dataservice::Metric.create :name => "Feature completion rate", :source => "JIRA", :dimension => "Implementation"
Dataservice::Metric.create :name => "Improvement Implemented", :source => "JIRA", :dimension => "Implementation"
Dataservice::Metric.create :name => "Features Implemented", :source => "JIRA", :dimension => "Implementation"

Dataservice::Metric.create :name => "High priority Features implementation ratio", :source => "JIRA", :dimension => "Implementation"
Dataservice::Metric.create :name => "Low priority Features Implementation ratio", :source => "JIRA", :dimension => "Implementation"

Dataservice::Metric.create :name => "High priority improvement implementation ratio", :source => "JIRA", :dimension => "Implementation"
Dataservice::Metric.create :name => "Low priority improvement implementation ratio", :source => "JIRA", :dimension => "Implementation"
Dataservice::Metric.create :name => "Improvement implementation ratio", :source => "JIRA", :dimension => "Implementation"

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