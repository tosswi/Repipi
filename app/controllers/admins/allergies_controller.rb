class Admins::AllergiesController < ApplicationController
  def create
    @allergy=Allergy.new(allergy_params)
    if @allergy.save
      redirect_to admins_allergies_path
    else
      render :index
    end
  end
  def index
    @allergies=Allergy.all
    @allergy=Allergy.new
  end

  def edit
    @allergy=Allergy.find(params[:id])
  end

  def update
     @allergy=Allergy.find(params[:id])
     if @allergy.update(allergy_params)
      redirect_to admins_allergies_path
     else
       render :index
     end
  end
  private
  def allergy_params
     params.require(:allergy).permit(:allergy)
  end
end
