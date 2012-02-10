desc "redis tasks"
namespace :redis do
  desc "flushes the db"
  task :flush => :start_server do
    redis = Redis.new()
    redis.flushdb
  end
  desc "loads the test database"
  task :load_test_db do
    redis = Redis.new()
    test_data = YAML.load_file("db/redis/test_data.yml")
    test_data.each{|k, v| redis.set(k, v)}
    puts "data loaded"
  end
  desc "start the redis server"
  task :start_server do
    system 'redis-server > log/redis.log &'
    puts 'server started'
  end
  desc "shutdown the redis server"
  task :stop_server do
    system 'redis-cli shutdown'
    puts 'redis shutdown'
  end
  desc 'sets up the test redis db'
  task :test_setup => [:flush, :load_test_db] 
end
