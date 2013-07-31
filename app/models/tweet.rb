class Tweet < ActiveRecord::Base
  belongs_to :user

  validates :username, :text, presence: true
end
