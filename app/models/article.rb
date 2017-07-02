class Article < ApplicationRecord
  belongs_to :user
  has_many :ratings, dependent: :destroy

  class << self
    def top_rating(limit)
      order(average_rating: :desc).limit(limit).pluck(:title, :content)
    end

    def public_ips
      UserIp.joins(:user).group(:user_ip).having('count("users"."nickname") >= 2')
            .pluck(:user_ip, 'array_agg("users"."nickname") as nicknames')
    end
  end
end
