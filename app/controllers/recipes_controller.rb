class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
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
    

  private
  
  def recipe_params
    params.require(:recipe).permit(:id, :name, :summary, :description, :created_at, :updated_at, :chef_id)
  end
end