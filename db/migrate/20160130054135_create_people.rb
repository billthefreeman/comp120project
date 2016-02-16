class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :user_name
      t.string :phone
      t.string :second_phone
      t.string :email
      t.integer :group_id

      t.timestamps null: false
    end
  end
end
