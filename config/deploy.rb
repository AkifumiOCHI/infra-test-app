# config/deploy.rb

# capistranoのバージョン固定
lock '3.8.1'

# デプロイするアプリケーション名
set :application, 'infra-test-app'

# cloneするgitのリポジトリ
set :repo_url, 'git@github.com:AkifumiOCHI/infra-test-app.git'

# deployするブランチ。デフォルトはmaster
# この記載をすることで bundle exec cap production deploy BRANCH=ブランチ名で特定のブランチをデプロイできるようになる
set :branch, ENV['BRANCH'] || 'master'

# deploy先のディレクトリ。
set :deploy_to, '/var/www/infra-test-app'

# シンボリックリンクをはるファイル。
set :linked_files, %w(config/secrets.yml config/database.yml .env)

# シンボリックリンクをはるフォルダ。
set :linked_dirs, %w(log tmp/pids tmp/cache tmp/sockets)

# 保持するバージョンの個数
set :keep_releases, 5

# rubyのバージョン
set :rbenv_ruby, '2.4.1'

# システムワイドにインストールされているRubyを使用する
set :rbenv_type, :system

# デプロイ実行時に出力するログのレベル。
set :log_level, :debug

set :default_env, {
	AWS_ACCESS_KEY_ID: ENV["AWS_ACCESS_KEY_ID"],
  AWS_SECRET_ACCESS_KEY: ENV["AWS_SECRET_ACCESS_KEY"]
}
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }
set :sidekiq_queue, :carrierwave
