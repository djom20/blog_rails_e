class WelcomeController < ApplicationController
	def index
		@articles = Article.limit(4)
	end
end