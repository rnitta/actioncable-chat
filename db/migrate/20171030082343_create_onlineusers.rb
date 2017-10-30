class CreateOnlineusers < ActiveRecord::Migration[5.1]
  def change
    create_table :onlineusers do |t|
      t.string :name

      t.timestamps
    end
  end
end
