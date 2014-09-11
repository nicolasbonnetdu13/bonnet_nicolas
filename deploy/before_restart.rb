remote_file "/srv/www/bonnet_nicolas/shared/config/database.yml" do
  source "https://raw.github.com/ei3kf/appl_rails/master/config/database.yml"
  owner "root"
  group "root"
  mode 0644
end

run "cd /srv/www/bonnet_nicolas/current && /usr/local/bin/bundle exec rake assets:precompile"
