class ChefsController < ApplicationController
  before_action :set_chef, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update]
  
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
  end
  
  def show
    @recipes = @chef.recipes.paginate(page: params[:page], per_page: 2)
  end
  
  def update
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
    
    def require_same_user
      if current_user != @chef
        flash[:danger] = "You can only edit your own profile"
        redirect_to root_path
      end
            
    end
    
    def set_chef
      @chef = Chef.find_by id: params[:id]
    end
end