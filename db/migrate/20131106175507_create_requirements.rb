class CreateRequirements < ActiveRecord::Migration
  def change
    create_table :requirements do |t|
      t.string :name
      t.datetime :date_completed
      t.boolean :status

      t.timestamps
    end
  end
end
