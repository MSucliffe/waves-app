server "IP_GOES_HERE", user: "USER_GOES_HERE", roles: %w(app db web)
set :stage, :staging
set :application, "USER_GOES_HERE"
set :deploy_to, "/var/www/USER_GOES_HERE"
set :environment, "staging"
set :migration_role, :app
set :keep_assets, 2
