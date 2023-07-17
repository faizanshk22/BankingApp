class Bank < ApplicationRecord

    validates :bank_name, presence: true, uniqueness: true

    has_many :accounts, dependent: :destroy
    has_many :users, through: :accounts

end
