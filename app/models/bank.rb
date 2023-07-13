class Bank < ApplicationRecord

    validates :bank_name, presence: true, uniqueness: true

    has_many :accounts

end
