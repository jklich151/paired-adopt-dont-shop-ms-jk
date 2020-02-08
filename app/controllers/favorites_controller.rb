class FavoritesController < ApplicationController

  def update
    pet = Pet.find(params[:pet_id])
    pet_id = pet.id.to_s
    favorite.add_pet(pet.id)
    session[:favorites] = favorite.contents
      flash[:notice] = "You now have added #{pet.name} to your favorites."
      redirect_to "/pets/#{pet.id}"
  end

  def index
    @pets = Pet.find(session[:favorites])
  end

  def destroy
    pet = Pet.find(params[:pet_id])
    pet_id = pet.id
    session[:favorites].delete(pet_id)
    flash[:notice] = "#{pet.name} has been removed from favorites."
    redirect_to "/pets/#{pet.id}"
  end
end
