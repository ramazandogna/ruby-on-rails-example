class Api::GreetingsController < ApplicationController
  # CSRF korumasını API için devre dışı bırak
  skip_before_action :verify_authenticity_token
  
  before_action :set_greeting, only: [:show, :destroy]
  
  # GET /api/greetings
  def index
    @greetings = Greeting.all.order(created_at: :desc)
    render json: @greetings
  end
  
  # GET /api/greetings/:id
  def show
    render json: @greeting
  end
  
  # POST /api/greetings
  def create
    @greeting = Greeting.new(greeting_params)
    
    if @greeting.save
      render json: @greeting, status: :created
    else
      render json: { errors: @greeting.errors }, status: :unprocessable_entity
    end
  end
  
  # DELETE /api/greetings/:id
  def destroy
    @greeting.destroy
    head :no_content
  end
  
  private
  
  def set_greeting
    @greeting = Greeting.find(params[:id])
  end
  
  def greeting_params
    params.require(:greeting).permit(:message, :language)
  end
end
