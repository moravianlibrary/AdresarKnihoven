class AddNoteToPhones < ActiveRecord::Migration
  def change
    add_column :phones, :note, :string
  end
end
