class ArticlesController < ApplicationController
#action should be defined in order: index, show, new, edit, create, update  and destroy.
  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

  def index
    @articles = Article.all
  end
  # declaring your variables in your controller as instance variables (@title) makes them available to your view.
  def show
    @article = Article.find(params[:id])    # action for path articles/:id
# Rails will pass all instance variables to the view.
  end

  def new  # action new for path /articles/new
    @article = Article.new
  #  we need initialize @article otherwise @article would be nil in our view, and calling @article.errors.any? would throw an error.
  end

  def edit
    @article = Article.find(params[:id])

  end

  def create  # action create
    # render plain: params[:article].inspect    # params from the form submission
    # @article = Article.new([params[:article]])    # initialize model with its respective attributes, cause "Strong Parameter"security error
    @article = Article.new(article_params)    # initialize model with its respective attributes
    if @article.save     # saving the model in the database
      redirect_to @article    # redirect to the show action
    else
      render 'new'    # The render method is used so that the @article object is passed back to the new template when it is rendered
      # This rendering is done within the same request as the form submission,
      # whereas the redirect_to will tell the browser to issue another request.
    end

  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

# We use the delete method for destroying resources, and this route is mapped to the destroy action
  def destroy
    @article = Article.find(params[:id])
    @article.destroy    # call destroy on Active Record objects when you want to delete them from the database.
    redirect_to articles_path
  end
# You can call destroy on Active Record objects when you want to delete them from the database.
# Note that we don't need to add a view for this action since we're redirecting to the index action.

  private
  def article_params
    params.require(:article).permit(:title, :text)
  end
end
