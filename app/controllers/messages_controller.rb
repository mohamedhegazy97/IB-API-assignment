class MessagesController < ApplicationController
  before_action :set_message, only: [:update]

  def search
    @chat = set_chat
    id = @chat.id
    res = elastic_search(id)
    render json: res.response["hits"]["hits"]
  end

  # GET /messages
  def index
    @chat = set_chat
    id = @chat.id
    find_messages_in_chat(id)
    render json: @messages
  end

  # POST /messages
  def create
    @chat = set_chat
    @message = @chat.message.new(message_params)
    set_chat_number
    set_message_count
    set_count
    publish
    render json: @message
  end

  # PATCH/PUT /messages/1
  def update
    update_message
    render json: @message
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def update_message
      Publisher.publish("chat", @message.update("content":params[:query]))
    end
    
    def find_messages_in_chat(id)
      @messages = Message.where("chat_id":"#{id}")
    end

    def elastic_search(id)
      query = params[:query]
      return Message.search(query,id)
    end

    def publish
      Publisher.publish("chat", @message.save)
      Publisher.publish("chat", @chat.update("message_count":"#{@chat.message_count}"))
    end 
    def set_count
      if Message.where("chat_id":"#{@chat.id}").count == 0
        @message.number = 1
      else
        @message.number = Message.last.number + 1
      end
    end

    def set_message_count
      @chat.message_count = @chat.message_count + 1
    end

    def set_chat_number
      @message.chat_number = params[:number]
    end

    def set_chat
      return Chat.find_by("number":"#{params[:number]}","AppToken":"#{params[:AppToken]}")
    end

    def set_message
      @message = Message.find_by(chat_number: params[:chat_number], number: params[:number])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:chat_number, :chat_id, :number, :content)
    end
end
