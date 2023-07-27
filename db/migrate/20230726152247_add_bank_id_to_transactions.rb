class AddBankIdToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :bank_id, :integer
  end
end
