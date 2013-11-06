class SetRequirementsStatusDefaultToFalse < ActiveRecord::Migration
  def change
    change_column :requirements, :status, :boolean, default: false
  end
end
