namespace :git do
  desc 'Heroku pre-push'
  task :heroku do
    Rake::Task["assets:precompile"].invoke
    %x{git add public}
    %x{git commit -m "pro heroku"}
    %x{git push heroku master -f}
    %x{git reset --hard HEAD^}
  end
end
