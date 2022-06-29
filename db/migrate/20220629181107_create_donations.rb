class CreateDonations < ActiveRecord::Migration[7.0]
  def change
    create_table :donations do |t|
      t.belongs_to :user, foreign_key: true
      t.string :title
      t.integer :current
      t.integer :need
      t.datetime :deadline

      t.timestamps
    end
  end
end
