class MessagesController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def create
		@conversation = Conversation.find(params[:conversation_id])
		@message = @conversation.messages.build(message_params)
		@message.person_id = current_person.id
		@message.created_at = DateTime.now

		mes = @message.to_json
		$redis.zadd('conversation_'+params[:conversation_id].to_s,(Time.now.to_f * 1).to_i, mes)
		
		#@message.save!

		@path = conversation_path(@conversation)

		#respond_to :html, :json
	end

	private


	def message_params
		params.require(:message).permit(:body)
	end
end
