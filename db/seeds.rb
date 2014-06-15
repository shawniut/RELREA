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
Dataservice::Metric.create :name => "Bug fix rate", :source => "JIRA", :dimension => "Testing"
Dataservice::Metric.create :name => "Defect find rate", :source => "JIRA", :dimension => "Testing"
Dataservice::Metric.create :name => "Feature completion rate", :source => "JIRA", :dimension => "Implementation"
Dataservice::Metric.create :name => "Features Implemented", :source => "JIRA", :dimension => "Implementation"
Dataservice::Metric.create :name => "Improvement Implemented", :source => "JIRA", :dimension => "Implementation"