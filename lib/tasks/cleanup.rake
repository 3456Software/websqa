desc 'Clean up the repository and delete logs/temp files'
task :clean do
  Rake::Task['log:clear'].invoke
  Rake::Task['tmp:clear'].invoke
  `git gc`
end
