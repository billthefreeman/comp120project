class ConversationsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  layout false

  def create
    if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
    render json: { conversation_id: @conversation.id }
  end

  def show
    @conversation = Conversation.find(params[:id])
    @reciever = interlocutor(@conversation)
    #@messages = @conversation.messages

    @arr = Message.where(:id=>0)
    
    $redis.zrangebyscore("conversation_"+params[:conversation_id].to_s ,0,(Time.now.to_f * 1).to_i , {withscores: true}).each do |source|
      mes = source[0]
      new_m = JSON.load mes
      @arr << Message.new(new_m)
    end  
    @messages = @arr

    @message = Message.new
  end

  private
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end

  def interlocutor(conversation)
    current_person == conversation.recipient ? conversation.sender : conversation.recipient
  end
end
