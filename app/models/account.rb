class Account < ApplicationRecord
  belongs_to :bank
  belongs_to :user 
  has_many :transactions , dependent: :destroy

  enum status: 
  { pending: 0,
     approved: 1, 
      declined: 2 }
  
  
  validates :status, presence: true
  validates :account_no, uniqueness: { scope: :bank_id }, allow_blank: true
  validate :user_can_have_only_one_account_per_bank
  
  before_save :generate_account_number, if: -> { status_changed? && approved? }

private

def generate_account_number
  self.account_no ||= SecureRandom.hex(6)
end

  
  def user_can_have_only_one_account_per_bank
    existing_account = Account.find_by(user_id: user_id, bank_id: bank_id)

    if existing_account && existing_account != self
      errors.add(:base, 'User already has an account in this bank')
    end
  end
end
