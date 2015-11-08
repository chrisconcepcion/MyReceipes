class StylesController < ApplicationController
  before_action :require_user, only: [:new, :create]


  def new
    @style = Style.new
  end
  
  def create
    @style = Style.new(style_params)
    if @style.save
      flash[:success] = "Your new style has been created!"
      redirect_to :home
    else
      render :new
    end
  end
  
  def show
    @style = Style.find_by id: params[:id]
    @recipes = @style.recipes.paginate(page: params[:page], per_page: 4)
  end
  
  private
    def style_params
      params.require(:style).permit(:name)
    end
  
end