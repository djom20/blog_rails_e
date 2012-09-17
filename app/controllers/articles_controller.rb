class ArticlesController < ApplicationController
  # GET /articles
  # GET /articles.json
  def index
     @articles = Article.order("created_at desc")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])
    @comment = @article.comments.new
    @comment.article_id = @article.id
    respond_to do |format|  
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    if current_user
      @article = Article.new
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @article }
      end
    else
      redirect_to new_user_path, :notice =>'Necesitas loguearte para crear un articulo'
    end
  end

  # GET /articles/1/edit
  def edit
    if current_user
      @article = Article.find(params[:id])
      unless current_user.id == @article.user.id || current_user.id == 1
        redirect_to new_article_path, :notice =>'No puedes editar el articulo indicado, si deaseas puedes crear otro'
      end
    else
      redirect_to new_user_path, :notice =>'Necesitas un usuario para editar un articulo'
    end
  end

  # POST /articles
  # POST /articles.json
  def create
    unless current_user
      redirect_to new_user_path, :notice =>'Necesitas un usuario para crear un articulo'
    end
    @article = Article.new(params[:article])
    @article.user_id = current_user.id

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render json: @article, status: :created, location: @article }
      else
        format.html { render action: "new" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.json
  def update
    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    if current_user
      @article = Article.find(params[:id])
      if current_user.id == @article.user.id || current_user.id == 1
        @article.destroy
      else
        redirect_to new_article_path, :notice =>'No puedes editar el articulo indicado, si deaseas puedes crear otro'
      end
    else
      redirect_to new_user_path, :notice =>'Necesitas un usuario para editar un articulo'
    end    

    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end

end
def category_list
  return self.categories.join(", ")
end
