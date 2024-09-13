lock "~> 3.19.1"

set :application, "californicus"
set :repo_url, "git@github.com:sugimite/californicus.git"
set :deploy_to, "/home/californicus/production"
set :branch, "main"
set :rbenv_type, :user
set :rbenv_ruby, "3.2.2"
set :default_env, {
  'RAILS_MASTER_KEY' => 'd91197584c009e5671b9d08a9a4c28e1'
}


append :linked_files, "config/database.yml", "config/master.key"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets"
