class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :status
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
