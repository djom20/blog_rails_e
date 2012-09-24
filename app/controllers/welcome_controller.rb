class WelcomeController < ApplicationController
	layout 'index_layout'
	def index
		@articles = Article.order("created_at desc").limit(4)
	end
end