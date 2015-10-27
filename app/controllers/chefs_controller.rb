class ChefsController < ApplicationController
  
  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 2)
  end
  
  def new
    @chef = Chef.new
  end
  
  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      flash[:success] = "You have successfully registered. Please log in."
      redirect_to recipes_path
    else
      flash[:danger] = "Opps, something went wrong!"
      render :new
    end
  end  
  
  def edit
    @chef = Chef.find_by id: params[:id]
  end
  
  def show
    @chef = Chef.find_by id: params[:id]
    @recipes = @chef.recipes.paginate(page: params[:page], per_page: 2)
  end
  
  def update
    @chef = Chef.find_by id: params[:id]
    if @chef.update(chef_params)
      flash[:success] = "Chef was successfully updated"
      redirect_to recipes_path
    else
      flash[:danger] = "Opps, something went wrong!"
      render :edit
    end
  end
  private
  
    def chef_params
      params.require(:chef).permit(:chefname, :email, :password)
    end
  
end