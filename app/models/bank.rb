class Bank < ApplicationRecord

    validates :bank_name, presence: true, uniqueness: true

end
