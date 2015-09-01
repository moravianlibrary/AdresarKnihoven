class CreateWebsites < ActiveRecord::Migration
  def change
    create_table :websites do |t|
      t.string :url
      t.string :note
      t.references :library, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
