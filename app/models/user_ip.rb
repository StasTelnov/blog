class UserIp < ApplicationRecord
  belongs_to :user

  class << self
    def after_create_article(article)
      find_or_create_by(user_ip: article.user_ip, user_id: article.user.id)
    end
  end
end
