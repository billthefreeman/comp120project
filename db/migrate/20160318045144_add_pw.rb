class AddPw < ActiveRecord::Migration
  def change
  	add_column :People, :pw, :string
  end
end
