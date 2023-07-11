class Bank < ApplicationRecord

    validates :bankName, presence: true, uniqueness: true

end
