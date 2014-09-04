namespace :guests do
  desc "Remove guest accounts more than a week old."
  task :cleanup => :environment do
    User.where(roles_mask: 8).where("created_at < ?", 1.week.ago).destroy_all
  end
end
