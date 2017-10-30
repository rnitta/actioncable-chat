class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.timestamps
    end

    add_index :users, :name, unique: true
    add_column :users, :password_digest, :string
  end
end
