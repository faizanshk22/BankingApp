class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :transaction_type
      t.decimal :amount
      t.references :account, null: false, foreign_key: true
      t.references :sender, references: :users
      t.references :receiver, references: :users
      t.timestamps
    end
  end
end
