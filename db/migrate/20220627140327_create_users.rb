class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :name
      t.string :phone
      t.timestamp :birthdate
      t.string :bio
      t.text :picture

      t.timestamps
    end
  end
end
