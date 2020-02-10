class ApplicationsController < ApplicationController

  def new
    @pets = Pet.find(session[:favorites])
  end

  def create
    application = Application.create(app_params)
    application.save
    flash[:notice] = "Your application has been submitted!"

    if params[:adopt_pets] == nil || !application.save
      flash[:notice] = "Form not submitted: Required information missing."
      redirect_to "/applications/new"
    else
      pets = Pet.find(params[:adopt_pets])
      pets.each do |pet|
        session[:favorites].delete(pet.id)
      end
      redirect_to '/favorites'
    end
  end

  private
    def app_params
      params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
    end
end
