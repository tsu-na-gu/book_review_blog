namespace :deploy do
  namespace :check do
    before :linked_files, :set_master_key do
      on roles(:app), in: :sequence, wait: 10 do
        unless test("[ -f #{shared_path}/config/master.key ]")
          upload! '/Users/tsu-na-gu/code/book_review_blog/config/master.key', "/home/rails/book_review_blog/config/master.key"
        end
        unless test("[ -f #{shared_path}/config/database.yml ]")
          upload! '/Users/tsu-na-gu/code/book_review_blog/config/database.yml', "/home/rails/book_review_blog/shared/config/database.yml"
        end
        unless test("[ -f #{shared_path}/config/credentials.yml.enc ]")
          upload! '/Users/tsu-na-gu/code/book_review_blog/config/credentials.yml.enc', "/home/rails/book_review_blog/shared/config/secrets.yml"
        end
        unless test("[ -f #{shared_path}/config/storage.yml ]")
          upload! '/Users/tsu-na-gu/code/book_review_blog/config/storage.yml', "/home/rails/book_review_blog/shared/config/storage.yml"
        end
      end
    end
  end
end
