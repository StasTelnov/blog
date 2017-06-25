class Article < ApplicationRecord
  belongs_to :user
  has_many :ratings

  class << self
    def top_rating(limit = 10)
      order(:average_rating => :desc).limit(limit)
    end

    def public_ips
      group(:user_ip).having('count(DISTINCT user_id) > 1').pluck(:user_ip)
    end
  end
end
