class RecipesController < ApplicationController
  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 2)
  end
  
  def show
    @recipe = Recipe.find_by id: params[:id]
  end
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef_id = 1
    if @recipe.save
      flash[:success] = "Your recipe was successfully created!"
      redirect_to recipe_path(@recipe.id)
    else
      render :new
    end
  end
  
  def edit
    @recipe = Recipe.find_by id: params[:id]
  end
  
  def update
    @recipe = Recipe.find_by id: params[:id]
    if @recipe.update(recipe_params)
      flash[:success] = "Your recipe has been updated successfully!"
      redirect_to recipe_path(@recipe.id)
    else
      render :edit
    end
  end
    
  def like
    @recipe = Recipe.find_by id: params[:id]
    like = Like.new(like: params[:like], chef_id: Chef.first, recipe_id: @recipe.id)
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
end