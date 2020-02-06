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
end
