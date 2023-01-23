class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthablee
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
