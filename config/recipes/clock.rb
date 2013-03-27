namespace :clock do
  desc "Make sure local git is in sync with remote."
  %w[start stop restart].each do |command|
    desc "#{command} clockwork"
    task command, roles: :app do
      run "cd #{current_release} && bundle exec rake clockwork:#{command} RAILS_ENV=production"
    end
    after "deploy:#{command}", "clock:#{command}"
  end
end
