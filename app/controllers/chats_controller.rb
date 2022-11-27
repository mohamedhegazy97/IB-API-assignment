class ChatsController < ApplicationController
  before_action :set_chat, only: [:show]

  # GET /chats
  def index
    find_chats_in_app
    render json: @chats
  end

  # GET /chats/1
  def show
    render json: show_user
    #render json: @chat
  end

  # POST /chats
  def create
    @application =  set_application
    @chat = @application.chat.new(chat_params)
    increment_app
    set_count
    set_number
    publish
    render json: show_user
    #render json: @chat
  end


  private
    # Use callbacks to share common setup or constraints between actions.
     def show_user
      return {"chat number": "#{@chat.number}","messages in chat": "#{@chat.message_count}"}
    end
    
    def find_chats_in_app
      @chats = Chat.where("AppToken":"#{params[:AppToken]}").select(:number , :message_count)
    end

    def publish
      Publisher.publish("chat", @chat.save)
      Publisher.publish("chat", @application.update("chat_count":"#{@application.chat_count}"))
    end

    def increment_app
      @application.chat_count = @application.chat_count + 1
    end

    def set_number
      if Chat.where("application_id":"#{@application.id}").count == 0
        @chat.number = 1
      else
        @chat.number = Chat.last.number + 1
      end
    end

    def set_count
      if @chat.message_count == nil
        @chat.message_count = 0
      end
    end

    def set_application
      return Application.find_by_token(params[:AppToken])
    end

    def set_chat
      @chat = Chat.find_by_number(params[:number])
    end

    # Only allow a list of trusted parameters through.
    def chat_params
      params.require(:chat).permit( :AppToken)
    end
end
