# EC2上でアプリケーションがデプロイされるディレクトリを変数に格納
app_path = '/var/www/infra-test-app'
app_shared_path = "#{app_path}/shared"

# unicornのプロセス停止などに必要なPIDファイルの保存先
pid "#{app_shared_path}/tmp/pids/unicorn.pid"

# unicornのUNIXドメインソケットの保存先
listen "#{app_shared_path}/tmp/sockets/unicorn.sock"

# unicornのログ出力先
stdout_path "#{app_shared_path}/log/unicorn.stdout.log"
stderr_path "#{app_shared_path}/log/unicorn.stderr.log"

# リクエストを処理するworkerの数
worker_processes 3

# 接続タイムアウトになるまでの時間(秒)
timeout 60

# Unicorn再起動時にダウンタイムなしで再起動するか（基本trueを設定)
preload_app true

# before starting processes
before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      Process.kill "QUIT", File.read(old_pid).to_i
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

# after finishing processes
after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
