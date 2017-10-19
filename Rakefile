# encoding: utf-8

#require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'

require 'cukeforker'
require 'cukeforker/rake_task'
require 'jsonpath'

#require 'cuke_sniffer'

require 'report_builder'

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

task :cleanup_cuke_forker do
  puts " ========Deleting old reports and logs========="
  #FileUtils.rm_rf('reports/test_report')
  Dir.mkdir("features/reports/test_report")
  ReportBuilder.configure do |config|
    config.json_path = 'reports/test_report'
    config.report_path = 'reports/test_report'
    config.report_tabs = [:overview, :features, :scenarios, :errors]
    config.report_title = 'Test Results'
    config.report
  end
end

task :all do
  Rake::Task['cleanup_cuke_forker'].invoke
  puts "===== Executing Tests in parallel"

  Dir.chdir('features/')

  CukeForker::Runner.run CukeForker::Scenarios.tagged('@carlos'), {:max => 10,
                                                     :log => true, :format => :json, :out => 'reports/test_report'}
  puts "===== End Executing Tests in parallel"
  puts "===== Executing report"
  ReportBuilder.build_report
  puts "===== End Executing report"

end