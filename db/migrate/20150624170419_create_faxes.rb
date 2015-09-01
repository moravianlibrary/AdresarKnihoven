class CreateFaxes < ActiveRecord::Migration
  def change
    create_table :faxes do |t|
      t.string :fax
      t.references :library, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
