class AddPw < ActiveRecord::Migration
  def change
  	add_column :people, :pw, :string
  end
end
