class SourcesController < ApplicationController

	def create
		@fact = Fact.find(params[:fact_id])
		if current_user !=nil
			@source = @fact.sources.create(source_params)
			@source.user_id =current_user.id
			@source.save
			flash[:success] ="Source successfully created"
			redirect_to fact_path(@fact)
		else
			flash[:danger] ="Sign in to create a source"
			redirect_to fact_path(@fact)
		end
	end

	def destroy
		@fact = Fact.find(params[:fact_id])
		if current_user !=nil
			@source = @fact.sources.find(params[:id])
			if @source.user_id == current_user.id
				@source.destroy
				flash[:success] ="Source successfully deleted"
				redirect_to fact_path(@fact)
			else
				flash[:danger] ="You can only delete your own sources"
				redirect_to fact_path(@fact)
			end
		else
			flash[:danger] ="You must sign in to delete"
			redirect_to fact_path(@fact)
		end
	end

	def upvote
 	 	@source = Source.find(params[:id])
 	 	print "USERS: "+ current_user.id.to_s
  	 		if @source.upvotes.create(user_id:current_user.id)
  	 			if @source.downvotes.exists?(user_id:current_user.id)
  	 				if @dvote =Downvote.where(source_id:@source.id).where(user_id:current_user.id).first
  	 					@dvote.destroy
  	 					print "DownVote deleted"
  	 				end
  	 			else
  	 				print "DownVote does not exist"
  	 			end
  	 			print "Vote success!!!!!!!!!!!!!"
  	 			respond_to do |format|
    				format.js {render :js =>"upDateCount(#{@source.upvotes.count},#{@source.downvotes.count},#{@source.id})"}
    			end
    		else
    			print "Vote not success!!!!!!!!"

    		end
  	end

  	def downvote
 	 	@source = Source.find(params[:id])
 	 	print "USERS: "+ current_user.id.to_s
 	 		if @source.downvotes.create(user_id:current_user.id)
 	 			if @source.upvotes.exists?(user_id:current_user.id)
 	 				if @uvote =Upvote.where(source_id:@source.id).where(user_id:current_user.id).first
 	 					@uvote.destroy
 	 					print "UpVote deleted"
 	 				end
 	 			else
 	 				print "UpVote does not exist"
 	 			end
 	 			print "Down Vote success!!!!!!!!!!!!!"
 	 			respond_to do |format|
 	 				#format.js {render :js =>"upDateCountDown(#{@source.downvotes.count},#{@source.id})"}
 	 				format.js {render :js =>"upDateCount(#{@source.upvotes.count},#{@source.downvotes.count},#{@source.id})"}
 	 			end
 	 		else
 	 			print "Down Vote not successful!!!!"


    		end
  	end

private

	def source_params
		params.require(:source).permit(:source)
	end

end
