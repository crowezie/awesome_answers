class QuestionsController < ApplicationController

  PER_PAGE = 10
  before_action :authenticate_user!, except: [:show, :index]
  before_action :find_question, only: [:show, :edit, :update, :destroy, :lock]

  before_action :authorize!, only: [:edit, :update, :destroy]


  def new
    @question = Question.new(title: "hello")
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    if @question.save
      # passing :notice / :alert ony works for redirect
      # flash[:notice] = "Question created!"
      redirect_to question_path(@question), notice: "Question created!"
    else
      flash[:alert] = "See errors below"
      render :new
    end
  end

  def show
    @answer = Answer.new
  end

  # Used to show a page with listing of all the questions in our DB
  def index
     if params[:search]
       @questions = Question.search(params[:search]).order("#{params[:order]}").page(params[:page]).per(PER_PAGE)
     else
       @questions = Question.order("#{params[:order]}").page(params[:page]).per(PER_PAGE)
     end
   end

  # GET /questions/:id/edit (e.g. /questions/123/edit)
  # this is used to show a form to edit and sub,it to update a question
  def edit
  end

  def update
    # if updating question is successful
    if @question.update question_params
      #redirecting to the question show page
      redirect_to question_path(@question)
    else
      # rendering the edit form so the user can see the errors.
      render :edit
    end

  end

  def destroy
      @question.destroy
      redirect_to questions_path
  end

  def lock
    @question.locked = !@question.locked
    @question.save
    redirect_to questions_path(@question)
  end




  private

  def question_params
    # this is usig the strong parameters feature in Rails to only allow the Title
    # and body to be updated in the database
    question_params = params.require(:question).permit([:title, :body, {tag_ids: []}, :locked, :category_id])
  end

  def find_question
    @question = Question.find params[:id]
  end

  def authorize!
      redirect_to root_path, alert: "access denied" unless can? :edit, @question
  end

end
