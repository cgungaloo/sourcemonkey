class FactsController < ApplicationController

	before_action :find_fact, only: [:edit, :update, :show, :delete]

  # Index action to render all posts
  def index
    @facts = Fact.search(params[:search])
  end

  # New action for creating post
  def new
    if current_user != nil
      @fact = Fact.new
    else
      flash[:danger] = "Sign in to create a fact"
      redirect_to facts_path
    end
  end

  # Create action saves the post into database
  def create
    @fact = Fact.new(fact_params)
    @fact.user_id = current_user.id
    if @fact.save
      flash[:notice] = "Successfully created post!"
      redirect_to fact_path(@fact)
    else
      flash[:alert] = "Error creating new post!"
      render :new
    end
  end

  # Edit action retrives the post and renders the edit page
  def edit
    if current_user == nil
      flash[:danger] = "Sign in to edit facts"
      redirect_to fact_path(@fact)
    elsif @fact.user_id != current_user.id
      flash[:danger] = "You can only update your own facts"
      redirect_to fact_path(@fact)
    end
  end

  # Update action updates the post with the new information
  def update
  	    @fact = Fact.find(params[:id])
        if @fact.update_attributes(fact_params)
          flash[:notice] = "Successfully updated post!"
          redirect_to fact_path(@fact)
        else
          flash[:alert] = "Error updating post!"
          render :edit
        end
  end

  # The show action renders the individual post after retrieving the the id
  def show
  end

  # The destroy action removes the post permanently from the database
  def destroy
    @fact = Fact.find(params[:id])
    if current_user !=nil
        if @fact.user_id == current_user.id
          if @fact.destroy
            flash[:notice] = "Successfully deleted fact!"
            redirect_to facts_path
          else
            flash[:danger] = "Error deleting fact"
            redirect_to fact_path(@fact)
          end
        else
          flash[:danger] = "You can only delete your own facts"
          redirect_to fact_path(@fact)
        end
    else
      flash[:danger] = "Sign in to delete facts"
      redirect_to fact_path(@fact)
    end

  end

  private

  def fact_params
    params.require(:fact).permit(:title, :context)
  end

  def find_fact
    @fact = Fact.find(params[:id])
  end
end
