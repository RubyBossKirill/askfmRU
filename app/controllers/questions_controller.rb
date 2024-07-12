class QuestionsController < ApplicationController
  before_action :set_question, only: %i[ show edit update ]
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
    @question = @user.questions.build(question_params)

    if @question.save
      redirect_to user_path(@user), notice: "Question was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def question_params
      params.require(:question).permit(:title, :body)
    end

    def set_user
      @user = User.find_by(user_id: params[:user_id])
    end
end
