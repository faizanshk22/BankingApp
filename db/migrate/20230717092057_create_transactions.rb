class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :transaction_type
      t.decimal :amount
      t.references :account, null: false, foreign_key: true
      t.bigint     :receiver_id
      t.integer    :bank_id
      t.timestamps
    end
  end
end
