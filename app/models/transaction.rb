class Transaction < ApplicationRecord
  belongs_to :account

  TRANSACTION_TYPE = ["withdraw","deposit"]

  validates :account, :transaction_type, :amount, presence: true
  validates :amount, numericality: true
  validates :transaction_type, inclusion: { in: TRANSACTION_TYPE}

end
