require 'cucumber'
require 'cucumber/rake/task'
require 'report_builder'

processes = ENV['processes'] || 10

Cucumber::Rake::Task.new('running_debug_tag_tests') do |t|
  #t.cucumber_opts = ["--tags", "@debug", "--tags", "~@pend", "--format", "report/report.html", "--out", "report.html", "--format", "junit", "--out", "testoutput", "--format", "pretty", "--format", "rerun", "--out", "rerun.txt"]
  t.cucumber_opts = ["--tags", "@debug"]
end

Cucumber::Rake::Task.new('running_all_tests') do |t|
  FileUtils.rm_rf('reports')
  Dir.mkdir('reports')
  t.cucumber_opts = ["--tags", "~@pend", "--format", "html", "--out", "reports/report.html", "--format", "junit", "--out", "testoutput", "--format", "pretty"]
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
