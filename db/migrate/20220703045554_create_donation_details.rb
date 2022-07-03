class CreateDonationDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :donation_details do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :donation, foreign_key: true
      t.string :metode
      t.integer :value
      t.string :doa
      t.boolean :anonymous

      t.timestamps
    end
  end
end
