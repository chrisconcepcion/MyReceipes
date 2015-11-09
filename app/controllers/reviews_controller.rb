class ReviewsController < ApplicationController
  before_action :require_user, only: [:create]
  

  def create
    @recipe = Recipe.find_by id: params[:id]
    @review = Review.new(review_params.merge(recipe_id: @recipe.id, chef_id: current_user.id))
    if @review.save
      flash[:success] = "Your review has been submitted!"
      redirect_to recipe_path(@recipe.id)
    else
      flash[:danger] = "Body can't be blank"
      redirect_to recipe_path(@recipe.id)
      
    end
  end
  
  private
  
    def review_params
      params.require(:review).permit(:body)
    end
  
end