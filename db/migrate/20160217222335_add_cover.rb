class AddCover < ActiveRecord::Migration
   def self.up
    add_attachment :incidents, :cover
  end

  def self.down
    remove_attachment :incidents, :cover
  end
end
