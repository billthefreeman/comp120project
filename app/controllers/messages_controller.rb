class MessagesController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def create
		@conversation = Conversation.find(params[:conversation_id])
		@message = @conversation.messages.build(message_params)
		@message.person_id = current_person.id
		@message.save!

		@path = conversation_path(@conversation)

		#respond_to :html, :json
	end

	private


	def message_params
		params.require(:message).permit(:body)
	end
end
