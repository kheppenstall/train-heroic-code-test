class Team

  attr_reader :name,
              :access_code

  def initialize
    @name        = Faker::Superhero.name
    @access_code = rand(100000000000000)
  end
end