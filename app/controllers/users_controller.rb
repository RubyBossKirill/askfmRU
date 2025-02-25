class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update ]
  before_action :authorize_user, except: %i[ index show new create ]

  # GET /users
  def index
    @users = User.all
  end
  
  # GET /users/1
  def show
    @questions = @user.questions.reject(&:new_record?)
    @question = @user.questions.build
  end

  # GET /users/new
  def new
    redirect_to root_path, alert: "Вы уже авторизованы!" if current_user.present?
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: "User was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: "User was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by(id: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :username)
    end

    def authorize_user
      reject_user unless @user == current_user
    end

    def reject_user
      redirect_to root_path, alert: "Вы не можете редактировать другого пользователя"
    end
end
