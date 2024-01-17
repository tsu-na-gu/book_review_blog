namespace :deploy do
  namespace :check do
    before :linked_files, :set_master_key do
      on roles(:app), in: :sequence, wait: 10 do
        unless test("[ -f #{shared_path}/config/master.key ]")
          upload! 'config/master.key', "#{shared_path}/config/master.key"
        end
      end
    end
    before :linked_files, :copy_database_setting do
      on roles(:app), in: :sequence, wait: 10 do
        unless test("[ -f #{shared_path}/config/database.yml ]")
          upload! 'config/database.yml', "#{shared_path}/shared/config/database.yml"
        end
      end
    end
    before :linked_files, :upload_secret_key do
      on roles(:app), in: :sequence, wait: 10 do
        unless test("[ -f #{shared_path}/config/secrets.yml ]")
          upload! 'config/secrets.yml', "#{shared_path}/shared/config/secrets.yml"
        end
      end
    end
  end
end