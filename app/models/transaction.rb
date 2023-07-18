class Transaction < ApplicationRecord
  belongs_to :account

  

  validates :account, :transaction_type, :amount, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
 


  def deposit?
    transaction_type == "Deposit"
  end

  def withdrawal?
    transaction_type == "Withdraw"
  end
end
