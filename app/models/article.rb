class Article < ApplicationRecord
  belongs_to :user
  has_many :ratings

  class << self
    def top_rating(limit)
      order(average_rating: :desc).limit(limit || 10).pluck(:title, :content)
    end

    def public_ips
      joins(:user).group(:user_ip).having('count(DISTINCT "articles"."user_id") > 1')
                  .pluck(:user_ip, 'array_agg(DISTINCT "users"."nickname") as nicknames')
    end
  end
end
