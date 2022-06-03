class CategoriesController < ApplicationController
  before_action :redirect_if_logged_off

  def index
  end

  def new
    @category = Categorie.new
  end

  def create
    category = Categorie.new(post_params)
    if category.save
      flash[:succes] = category.name + " " + t("controller.category.categ_added")
      redirect_to action: "new"
    else
      @category = category
      render :action => :edit
    end
  end

  def edit
  end

  def update
  end

  def post_params
    params.require(:categorie).permit(:name)
  end
end
