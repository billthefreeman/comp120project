module MessagesHelper
	def self_or_other(message)
		message.person == current_person ? "self" : "other"
	end

	def message_interlocutor(message)
		message.person == message.conversation.sender ? message.conversation.sender : message.conversation.recipient
	end
end
