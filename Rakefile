# encoding: utf-8

#require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'

require 'cukeforker'
require 'cukeforker/rake_task'
require 'jsonpath'

require 'report_builder'

task "move_to_test_directory" do
  Dir.chdir('features')
end

Cucumber::Rake::Task.new("running_geo_api_tests") do |t|
   # t.cucumber_opts = ["--tags", "@carlos", "--tags", "~@pend", "--format", "html", "--out", "report.html", "--format", "junit", "--out", "testoutput", "--format", "pretty", "--format", "rerun", "--out", "rerun.txt"]
  t.cucumber_opts = ["--tags", "@carlos"]
end

Cucumber::Rake::Task.new("running_all_tests") do |t|
  # t.cucumber_opts = ["--tags", "@carlos", "--tags", "~@pend", "--format", "html", "--out", "report.html", "--format", "junit", "--out", "testoutput", "--format", "pretty", "--format", "rerun", "--out", "rerun.txt"]
  t.cucumber_opts = ["--tags", "~@pend"]
end

# Cucumber::Rake::Task.new("running_parallel_geo_api_tests") do
#   CukeForker::Runner.run CukeForker::Scenarios.all
#   #extra_args: %W[-f CukeForker::Formatters::JunitScenarioFormatter --out results/junit]
# end

task :cleanup_cuke_forker do
  puts " ========Deleting old reports and logs========="
  FileUtils.rm_rf('features/tmp_reports')
  Dir.mkdir('features/tmp_reports')

  ReportBuilder.configure do |config|
    config.json_path    = 'features/tmp_reports'
    config.report_path  = 'reports'
    config.report_tabs  = [:overview, :features, :scenarios, :errors]
    config.report_title = 'Test Results'
    #config.report
  end
end


task :all do
  Rake::Task['cleanup_cuke_forker'].invoke
  puts "===== Executing Tests in parallel"

  Dir.chdir('features/')

  CukeForker::Runner.run CukeForker::Scenarios.tagged('@carlos'), {:max => 20,
                                                                   :log => true, :format => :json, :out => 'features/tmp_reports'}
  puts "===== End Executing Tests in parallel"
  puts "===== Executing report"
  #Dir.chdir('/')
  ReportBuilder.build_report
  puts "===== End Executing report"
end
