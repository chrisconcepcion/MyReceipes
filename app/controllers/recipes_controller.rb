class RecipesController < ApplicationController
   before_action :set_recipe, only: [:edit, :update, :show, :like]
   before_action :require_user, only: [:edit, :update, :like]
   before_action :require_same_user, only: [:edit, :update]
   
  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 2)
  end
  
  def show
  end
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef_id = current_user.id
    if @recipe.save
      flash[:success] = "Your recipe was successfully created!"
      redirect_to recipe_path(@recipe.id)
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @recipe.update(recipe_params)
      flash[:success] = "Your recipe has been updated successfully!"
      redirect_to recipe_path(@recipe.id)
    else
      render :edit
    end
  end
    
  def like
    like = Like.new(like: params[:like], chef_id: current_user.id, recipe_id: @recipe.id)
    if like.save
      flash[:success] = "Your selection was successful"
      redirect_to :back
    else
      flash[:danger] = "You can only like/dislike a recipe once"
      redirect_to :back
    end
  end
    
  private
  
  def recipe_params
    params.require(:recipe).permit(:id, :name, :summary, :description, :created_at, :updated_at, :chef_id, :picture)
  end
  
  def set_recipe
    @recipe = Recipe.find_by id: params[:id]
  end
  
  def require_same_user
    if @recipe.chef != current_user
      flash[:danger] = "You are not allowed to do this action"
      redirect_to :home
    end
  end
end