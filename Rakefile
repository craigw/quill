require 'cucumber/rake/task'
require 'spec/rake/spectask'
require 'spec/rake/verify_rcov'

namespace :features do
  Cucumber::Rake::Task.new(:all) do |t|
    t.profile = "default"
  end

  Cucumber::Rake::Task.new(:wip) do |t|
    t.profile = "wip"
  end

  Cucumber::Rake::Task.new(:ok) do |t|
    t.profile = "ok"
  end
end
task :features => :"features:all"

coverage_data = "coverage.data"
Spec::Rake::SpecTask.new do |t|
  t.ruby_opts = %W( -I spec -I lib )
  t.spec_opts = %W(
    --colour
    --format progress
    --loadby mtime
    --reverse
    --format html:coverage/index.html
  )
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.rcov = true
  t.rcov_opts =  %W(--exclude gems/,spec/,.bundle/)
  t.rcov_opts += %W(--aggregate #{coverage_data})
  t.rcov_opts += %W(-o coverage)
end

task :clear_coverage_data do
  File.unlink(coverage_data) if File.exists?(coverage_data)
end

RCov::VerifyTask.new(:verify_rcov => [ :clear_coverage_data, :spec ]) do |t|
  t.threshold = 100.0
end

task :default => :verify_rcov
