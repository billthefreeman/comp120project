class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :person

  validates_presence_of :body, :conversation_id, :person_id
end
