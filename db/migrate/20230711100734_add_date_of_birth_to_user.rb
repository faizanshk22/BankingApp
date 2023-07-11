class AddDateOfBirthToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :dateofbirth, :date
  end
end
