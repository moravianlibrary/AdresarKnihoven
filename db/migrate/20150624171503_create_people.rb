class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :degree1
      t.string :degree2
      t.string :role
      t.string :addressing
      t.references :library, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
