class AddCategoryPriorityLastUpdateToLibrary < ActiveRecord::Migration
  def change
    add_column :libraries, :category, :string
    add_column :libraries, :priority, :integer
    add_column :libraries, :last_update, :string
  end
end
