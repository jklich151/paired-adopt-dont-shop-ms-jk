class Favorite
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Array.new
  end

  def total_count
    @contents.length
  end

  def add_pet(pet_id)
    @contents << pet_id
  end

  def include_pet?(pet_id)
    @contents.any? do |content|
      content == pet_id.to_i
    end
  end

  def pets
    @contents.map do |id|
      Pet.find(id)
    end
  end
end
