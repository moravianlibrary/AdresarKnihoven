class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :phone
      t.references :library, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_foreign_key :phones, :libraries
  end
end
