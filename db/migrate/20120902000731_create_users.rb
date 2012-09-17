class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :mail
      t.integer :age
      t.text :bio
      t.integer :status
      t.string :password

      t.timestamps
    end
  end
end
