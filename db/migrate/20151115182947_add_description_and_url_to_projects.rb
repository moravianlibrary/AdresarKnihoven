class AddDescriptionAndUrlToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :description, :string
    add_column :projects, :url, :string
  end
end
