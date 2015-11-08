class RecipesController < ApplicationController
   before_action :set_recipe, only: [:edit, :update, :show, :like]
   before_action :require_user, only: [:edit, :update, :like]
   before_action :require_same_user_or_admin, only: [:edit, :update]
   before_action :require_admin, only: [:delete]
   
   
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
    binding.pry
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
  
  def destroy
    recipe = Recipe.find_by id: params[:id]
    recipe.destroy
    flash[:success] = "You have successfully destroyed a recipe"
    redirect_to recipes_path
  end
    
  private
  
  def recipe_params
    params.require(:recipe).permit(:id, :name, :summary, :description, :created_at, :updated_at, :chef_id, :picture, { :style_ids => [] }, { :ingredient_ids => [] } )
  end
  
  def set_recipe
    @recipe = Recipe.find_by id: params[:id]
  end
  
  def require_same_user_or_admin
    if @recipe.chef != current_user && !current_user.admin?
      flash[:danger] = "You are not allowed to do this action"
      redirect_to :home
    end
  end
  
  def require_admin
    if !current_user.admin?
      flash[:danger] = "This action can only be preformed by an admin"
      redirect_to recipes_path
    end
  end
end