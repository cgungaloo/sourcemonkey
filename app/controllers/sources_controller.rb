class SourcesController < ApplicationController

	def create
		@fact = Fact.find(params[:fact_id])
		@source = @fact.sources.create(source_params)
		flash[:notice] ="Source successfully created"
		redirect_to fact_path(@fact)
	end

	def destroy
		@fact = Fact.find(params[:fact_id])
		@source = @fact.sources.find(params[:id])
		@source.destroy
		flash[:notice] ="Source successfully deleted"
		redirect_to fact_path(@fact)
		
	end

	def upvote
 	 	@source = Source.find(params[:id])
  	 	@source.upvotes.create
  	 	respond_to do |format|
    	format.js {render :js =>"upDateCount(#{@source.upvotes.count})"}
    	end
  	end

  	def downvote
 	 	@source = Source.find(params[:id])
  	 	@source.downvotes.create
  	 	respond_to do |format|
    	format.js {render :js =>"upDateCountDown(#{@source.downvotes.count})"}
    	end
  	end

private

	def source_params
		params.require(:source).permit(:source)
	end

end
