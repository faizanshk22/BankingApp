class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  belongs_to :bank

  validates  :amount, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
 


  # def deposit?
  #   transaction_type == "Deposit"
  # end

  # def withdrawal?
  #   transaction_type == "Withdraw"
  # end
end
