class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name,:last_name,:email,:date_of_birth,:phone,:gender, presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, uniqueness: true 
  
  has_many :pending_accounts, -> { where(status: :pending) }, class_name: 'Account'
  has_one_attached :header_image

  has_many :accounts , dependent: :destroy

                             
end
