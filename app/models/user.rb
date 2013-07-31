class User < ActiveRecord::Base
  has_many :tweets
  
  def tweet(status)
    tweet = tweets.create!(:status => status)
    TweetWorker.perform_async(tweet.id)
  end   

  def tweets
    Tweet.find_by(user_id: self.id)
  end
end
