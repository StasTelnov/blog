class Article < ApplicationRecord
  belongs_to :user
  has_many :ratings, dependent: :destroy

  class << self
    def top_rating(limit)
      order(average_rating: :desc).limit(limit || 10).pluck(:title, :content)
    end

    def public_ips
      UserNicknameIp.group(:user_ip).having('count("user_nickname_ips"."nickname") >= 2')
                    .pluck(:user_ip, 'array_agg("user_nickname_ips"."nickname") as nicknames')
    end
  end
end
