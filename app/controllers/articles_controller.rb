class ArticlesController < ApplicationController
	before_action :set_article, only:[:edit, :show, :destroy, :update]
	before_action :require_user, except:[:index, :show]
	before_action :require_same_user, only:[:edit, :update, :destroy]
	
	def new

		@article =Article.new

	end

	def index

		   @articles = Article.paginate(page: params[:page], per_page: 5)
	end

	def edit
		
	end

	def create
		#render plain: params[:article].inspect
		#debugger
		@article = Article.new(article_params)
	   	@article.user = current_user
	   	#User.find(session[:user_id])
	   	# @article.user = User.first
	   	
		if @article.save
			flash[:success] = "Article was succesfully created"
			redirect_to  "/articles/#{@article.id}" #articles_path(@article)
		else
			render 'new'
		end
	end
	
	def show
	
	end
	def destroy
		
		@article.destroy
		flash[:danger]="Article deleted successfully"
		redirect_to articles_path
	end

	def update
		if @article.update(article_params)
			flash[:success] ="selected article updated"
			redirect_to articles_path(@article)
		else
			render 'edit'
		end
	end

	private
	def set_article
			@article = Article.find(params[:id])
	end

	def article_params
		params.require(:article).permit(:title, :description)
	end
	def require_same_user
		if current_user != @article.user

			flash[:danger]= "You can only edit your own account!!"
			redirect_to root_path
		end
	end




end
