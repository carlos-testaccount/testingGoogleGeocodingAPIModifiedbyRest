require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'
#require 'cukeforker'
#require 'cukeforker/rake_task'

task "move_to_test_directory" do
  Dir.chdir('features')
end

Cucumber::Rake::Task.new("running_geo_api_tests") do |t|
  # t.cucumber_opts = ["--tags", "@carlos", "--tags", "~@pend", "--format", "html", "--out", "report.html", "--format", "junit", "--out", "testoutput", "--format", "pretty", "--format", "rerun", "--out", "rerun.txt"]
  t.cucumber_opts = ["--tags", "@carlos"]
end


# Cucumber::Rake::Task.new("running_parallel_geo_api_tests") do
#   CukeForker::Runner.run CukeForker::Scenarios.all
#   #extra_args: %W[-f CukeForker::Formatters::JunitScenarioFormatter --out results/junit]
# end