class Account < ApplicationRecord
  belongs_to :bank
  belongs_to :user 


  validates :account_no, :balance, presence: true
  validates :account_no, uniqueness: true
  validate :user_can_have_only_one_account_per_bank

  private

  def user_can_have_only_one_account_per_bank
    existing_account = Account.find_by(user_id: user_id, bank_id: bank_id)

    if existing_account && existing_account != self
      errors.add(:base, 'User already has an account in this bank')
    end
  end
end
