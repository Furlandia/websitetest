task :default => :server

task :clean do
  sh 'rm -rf build/*'
end

task :server do
  middleman 'server'
end

task :build do
  middleman 'build'
end

task :deploy => :build do
  branch = `git rev-parse --abbrev-ref HEAD`.strip
  target = case ENV['SITE']
           when 'prod'
             abort 'Only master can be deployed to production' if branch != 'master'
             'furlandia:/srv/www/2017/'
           when 'test'
             'furlandia:/srv/www-test/2017'
           else
             'furlandia:/srv/www-dev/2017'
           end

  sh "rsync -rtzh --progress --chmod=664 --delete build/ #{target}"
end

def middleman(args)
  sh "bundle exec middleman #{args}"
end
