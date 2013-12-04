class AddDescriptionToRequirement < ActiveRecord::Migration
  def change
    add_column :requirements, :description, :text
  end
end
