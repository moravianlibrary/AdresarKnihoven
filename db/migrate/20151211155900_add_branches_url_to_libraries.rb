class AddBranchesUrlToLibraries < ActiveRecord::Migration
  def change
    add_column :libraries, :branches_url, :string
  end
end
