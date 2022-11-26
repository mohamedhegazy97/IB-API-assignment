class PostsWorker
    include Sneakers::Worker
    # This worker will connect to "dashboard.chat" queue
    # env is set to nil since by default the actuall queue name would be
    # "dashboard.chat_development"
    from_queue "dashboard.chat", env: nil
  
    # work method receives message payload in raw format
    # in our case it is JSON encoded string
    # which we can pass to RecentPosts service without
    # changes
    def work(raw_post)
      RecentPosts.push(raw_post)
      ack! # we need to let queue know that message was received
    end
  end