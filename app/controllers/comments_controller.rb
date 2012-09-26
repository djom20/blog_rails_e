class CommentsController < ApplicationController
	def index
		@commens = Comment.all
	end
	def new
		@comment = Comment.new
	end
	def create
		article_id = params[:comment].delete(:article_id)
    	@comment = Comment.new
    	@comment.body = params[:comment][:body]
    	@comment.article_id = article_id
    	@comment.save(validate: false)
    	redirect_to article_path(@comment.article)
	end
	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
		redirect_to article_path(@comment.article)
	end
end