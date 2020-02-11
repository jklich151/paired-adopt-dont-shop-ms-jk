class PetsController < ApplicationController

  def index
    if params[:shelter_id]
      @shelter = Shelter.find(params[:shelter_id])
      @pets = @shelter.pets
    else
      @pets = Pet.all
    end
  end

  def new
    @shelter_id = params[:shelter_id]
  end

  def create
    pet = Pet.new({
      image: params[:image],
      name: params[:name],
      age: params[:age],
      sex: params[:sex],
      description: params[:description],
      status: params[:status],
      shelter_id: params[:shelter_id]
      })

    pet.save

    redirect_to "/shelters/#{pet.shelter_id}/pets"
  end

  def show
    @pet = Pet.find(params[:id])
    if !@pet.applications.empty?
      @app = @pet.applications.first
    end
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update_status
    @pet = Pet.find(params[:pet_id])
    if @pet.status == "adoptable"
      @pet.update_attribute(:status, "pending")
      redirect_to "/pets/#{@pet.id}"
    else
      @pet.update_attribute(:status, "adoptable")
      app = Application.find(params[:applications_id])
      redirect_to "/applications/#{app.id}"
    end
  end

  def update
    pet = Pet.find(params[:id])
    shelter_id = pet.shelter_id
    status = pet.status
    pet.update ({
      image: params[:image],
      name: params[:name],
      age: params[:age],
      sex: params[:sex],
      description: params[:description]
      })

      pet.save
      redirect_to "/pets/#{pet.id}"
  end

  def destroy
    Pet.destroy(params[:id])
    redirect_to '/pets'
  end

  private
    def pet_params
      params.permit(:shelter_id, :status)
    end
end
