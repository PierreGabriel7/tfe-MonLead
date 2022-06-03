class User < ApplicationRecord

  has_many :cognito_sessions

  has_one_attached :avatar

end

