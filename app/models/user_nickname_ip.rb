class UserNicknameIp < ApplicationRecord
  class << self
    def after_create_article(article)
      find_or_create_by(user_ip: article.user_ip, nickname: article.user.nickname)
    end
  end
end
