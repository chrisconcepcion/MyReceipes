class IngredientsController < ApplicationController
  before_action :require_user, only: [:new, :create]
  
  def new
    @ingredient = Ingredient.new
  end
  
  def create
    @ingredient = Ingredient.new(ingredientParams)
    if @ingredient.save
      flash[:success] = "You have created a new ingredient!"
      redirect_to :home
    else
      render :new
    end
  end
  
  def show
    @ingredient = Ingredient.find_by id: params[:id]
    @recipes = @ingredient.recipes.paginate(page: params[:page], per_page: 2)
  end
 
  private
    def ingredientParams
      params.require(:ingredient).permit(:name)
    end
end