# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

require 'sneakers/tasks'

Rails.application.load_tasks


namespace :rabbitmq do
    desc "Setup routing"
    task :setup do
      require "bunny"
  
      conn = Bunny.new(host:  'rabbitmq',
      port:  '5672',
      vhost: '/',
      user:  'guest',
      pass:  'guest')
      conn.start
  
      ch = conn.create_channel
  
      # get or create exchange
      x = ch.fanout("blog.chat")
  #    y = ch.fanout("blog.message")
  
      # get or create queue (note the durable setting)
      queue = ch.queue("dashboard.chat", durable: true)
 #     queue = ch.queue("dashboard.message", durable: true)
  
      # bind queue to exchange
      queue.bind("blog.chat")
#      queue.bind("blog.message")
  
      conn.close
    end
  end