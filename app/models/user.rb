class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :all_except, ->(user) { where.not(id: user) } # muestra a todos menos al current que ya esta mostrado arriba
  after_create_commit { broadcast_append_to 'users' }

  has_many :messages
end
