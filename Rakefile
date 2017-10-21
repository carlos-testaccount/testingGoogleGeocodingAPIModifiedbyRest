require 'cucumber'
require 'cucumber/rake/task'
require 'cukeforker'
require 'cukeforker/rake_task'

require 'report_builder'

processes = ENV['processes'] || 10


task 'running_geo_api_tests' do
  t.cucumber_opts = ["--tags", "@carlos", "--tags", "~@pend", "--format", "report/report.html", "--out", "report.html", "--format", "junit", "--out", "testoutput", "--format", "pretty", "--format", "rerun", "--out", "rerun.txt"]
end

task 'running_all_tests' do
  t.cucumber_opts = ["--tags", "~@pend", "--format", "html", "--out", "report/report.html", "--format", "junit", "--out", "testoutput", "--format", "pretty", "--format"]
end

task 'prepare_parallel_report' do
  FileUtils.rm_rf('reports')
  Dir.mkdir('reports')

  puts "configure reportbuilder"
  ReportBuilder.configure do |config|
    config.json_path    = 'tmp_reports'
    config.report_path  = 'reports/reports'
    config.report_types = [:json, :html]
    config.report_tabs  = [:overview, :features, :scenarios, :errors]
    config.report_title = 'Test Results'
    config.report
  end
end

task 'create_report' do
  ReportBuilder.build_report
  FileUtils.rm_rf('tmp_reports')
end

task 'parallel_all_tests' do
  Rake.application.invoke_task('prepare_parallel_report')

  FileUtils.rm_rf('tmp_reports')
  Dir.mkdir('tmp_reports')

  system "bundle exec parallel_cucumber  -n #{processes} features/ -o \'-p parallel -f json -o tmp_reports/feature$TEST_ENV_NUMBER.json \'"
  #system "bundle exec parallel_cucumber features/ -o \"-r features -p parallel \" -n #{processes} " or exit!($?.exitstatus)
  Rake.application.invoke_task('create_report')
end


#######
# task 'cuke_forker_all' do
#   Rake.application.invoke_task('prepare_parallel_report')
#   FileUtils.rm_rf('tmp_reports')
#   Dir.mkdir('tmp_reports')
#
#   puts "===== Executing Tests in parallel"
#   Dir.chdir('features/')
#
#   CukeForker::Runner.run CukeForker::Scenarios.all, {:max => 40,
#                                                      :log => true, :format => :json}
#
#   puts "===== End Executing Tests in parallel"
#   puts "===== Executing report"
#   Rake.application.invoke_task('create_report')
#   puts "===== End Executing report"
# end
