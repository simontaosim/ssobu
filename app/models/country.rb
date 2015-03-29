class Country
  include Mongoid::Document
  belongs_to :planet
  field :name, type: String

  def get_all_countries(planet)
  	@countries = Planet.findAll(planet_id: planet._id)
  end


end
