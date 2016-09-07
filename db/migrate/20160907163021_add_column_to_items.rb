class AddColumnToItems < ActiveRecord::Migration
  def change
    add_column :items, :truck_id, :integer
  end
end
