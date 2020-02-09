class ApplicationsController < ApplicationController

  def new
    @pets = Pet.find(session[:favorites])
  end

  def create
    application = Application.create(app_params)
    application.save
    flash[:notice] = "Your application has been submitted!"
    pets = Pet.find(params[:adopt_pets])

    if application.save
      pets.each do |pet|
        session[:favorites].delete(pet.id)
      end
    end

    redirect_to '/favorites'
  end

  private
    def app_params
      params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
    end
end
