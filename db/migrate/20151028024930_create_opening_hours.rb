class CreateOpeningHours < ActiveRecord::Migration
  def change
    create_table :opening_hours do |t|
      t.references :library, index: true, foreign_key: true
      t.string :mo
      t.string :tu
      t.string :we
      t.string :th
      t.string :fr
      t.string :sa
      t.string :su
      t.string :note

      t.timestamps null: false
    end
  end
end
