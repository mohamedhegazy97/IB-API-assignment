class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :update]

  # GET /applications
  def index
    @applications = Application.all
    render json: @applications
  end

  # GET /applications/1
  def show
    render json: show_user
    #render json: @application
  end

  # POST /applications
  def create
    token = create_token
    @application = Application.new(application_params)
    set_token(token)
    set_count
    publish
    #render json: @application
    render json: show_user_created(token)
  end

  # PATCH/PUT /applications/1
  def update
    Publisher.publish("chat", @application.update(application_params))
    render json: show_user
    #render json: @application
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def show_user_created(token)
      return {"apptoken": "#{token}","name": "#{@application.name}","chat_count": "#{@application.chat_count}"}
    end
    
    def show_user
      return {"apptoken": "#{@application.token}","name": "#{@application.name}","chat_count": "#{@application.chat_count}"}
    end 
    
    def publish
      Publisher.publish("chat", @application.save)
    end

    def set_count
      if @application.chat_count == nil
        @application.chat_count = 0
      end  
    end
    
    def set_token(token)
      @application.token = token
    end

    def create_token
      random_token = SecureRandom.urlsafe_base64(nil, false)
      while Application.find_by_token(random_token) != nil
        random_token = SecureRandom.urlsafe_base64(nil, false)
      end
      return random_token
    end

    def set_application
      @application = Application.find_by_token(params[:token])
    end

    # Only allow a list of trusted parameters through.
    def application_params
      params.require(:application).permit(:name, :token)
    end
end
