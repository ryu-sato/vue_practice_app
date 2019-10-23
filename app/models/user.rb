class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  scope :find_or_create_for_oauth, lambda { |oauth|
    User.find_by(uid: oauth.uid, provider: oauth.provider) ||
      User.create(
        uid:      oauth.uid,
        provider: oauth.provider,
        email:    oauth.info.email,
        password: Devise.friendly_token[0, 20])
  }
end
