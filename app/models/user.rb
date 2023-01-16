class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :recipes
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def self.guest
    find_or_create_by!(email: "guest@example1.com") do |user|
      user.password = SecureRandom.urlsafe_base64
       #user.confirmed_at = Time.now # ← Confirmable を設定してっsいる場合は追加
      user.first_name = "ユーザー" # ←ユーザー名を設定している場合は追加
      user.last_name = "ゲスト"
      user.first_name_kana = ""
      user.last_name_kana = ""
    end
  end

  def active_for_authentication?
    super && (self.is_deleted == false)
  end

end
