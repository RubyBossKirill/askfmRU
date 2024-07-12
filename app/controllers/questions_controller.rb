class QuestionsController < ApplicationController
  before_action :set_question, only: %i[ show edit update ]
  before_action :set_user

  # GET /questions
  def index
    @questions = Question.all
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # POST /questions
  def create
    @question = @user.questions.build(question_params)

    if @question.save
      redirect_to @user, notice: "Question was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find_by(id: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_params
      params.require(:question).permit(:title, :body)
    end

    def set_user
      @user = User.find_by(id: params[:id])
    end
end
