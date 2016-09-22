class FactsController < ApplicationController

	before_action :find_fact, only: [:edit, :update, :show, :delete]

  # Index action to render all posts
  def index
    # @facts = Fact.all
    @facts = Fact.search(params[:search])
  end

  # New action for creating post
  def new
    @fact = Fact.new
  end

  # Create action saves the post into database
  def create
    @fact = Fact.new(fact_params)
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
    if @fact.destroy
      flash[:notice] = "Successfully deleted post!"
      redirect_to facts_path
    else
      flash[:alert] = "Error updating post!"
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
