class AddDefaultValue < ActiveRecord::Migration
  def change
  change_column :incidents , :status_id , :integer , :default => 1
  end
end
