class RemoveEmailFromLibraries < ActiveRecord::Migration
  def change
    remove_column :libraries, :email, :string
  end
end
