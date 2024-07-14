class QuestionsController < ApplicationController
  before_action :set_user

  # GET /questions
  def index
    @questions = @user.questions
  end

  # GET /questions/new
  def new
    @question = @user.questions.build
  end

  # POST /questions
  def create
    if current_user == nil
      redirect_to log_in_path, alert: "Авторизуйтесь, чтобы задавать вопросы!"
    else
      if current_user == @user
        redirect_to user_path(@user), alert: "Вы не можете задать сами себе вопрос"
      else
        @question = @user.questions.build(question_params)
        if @question.save
          redirect_to user_path(@user), notice: "Question was successfully created."
        else
          redirect_to user_path(@user), alert: "Question not valid."
        end
      end
    end
  end

  def destroy
    redirect_to user_path(params[:user_id]), alert: "Вопрос удалён"
  end

  private
    # Only allow a list of trusted parameters through.
    def question_params
      params.require(:question).permit(:title, :body)
    end

    def set_user
      @user = User.find_by(id: params[:user_id])
    end
end
