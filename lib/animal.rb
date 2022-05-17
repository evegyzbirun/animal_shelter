class Animal
  attr_reader :id, :gender, :admit_date
  attr_accessor :name, :type, :breed

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @gender = attributes.fetch(:gender)
    @admit_date = attributes.fetch(:admit_date)
    @type = attributes.fetch(:type)
    @breed = attributes.fetch(:breed)
    @id = attributes.fetch(:id)
  end

  def ==(animal_to_compare)
    (self.name == animal_to_compare.name) && (self.id == animal_to_compare.id)
  end
  
  def self.all
    returned_animals = DB.exec("SELECT * FROM animals;")
    animals = []
    returned_animals.each do |animal|
      name = animal.fetch("name")
      gender = animal.fetch("gender")
      admit_date = animal.fetch("admit_date")
      type = animal.fetch("type")
      breed = animal.fetch("breed")
      id = animal.fetch("id").to_i
      animals.push(Animal.new({:name => name, :gender => gender, :admit_date => admit_date, :type => type, :breed => breed, :id => id}))
    end
    animals
  end

  def self.clear
    DB.exec("DELETE FROM animals *;")
  end

  def self.find(id)
    animal = DB.exec("SELECT * FROM animals WHERE id = #{id};").first
    name = animal.fetch("name")
    gender = animal.fetch("gender")
    admit_date = animal.fetch("admit_date")
    type = animal.fetch("type")
    breed = animal.fetch("breed")
    id = animal.fetch("id").to_i
    Animal.new({:name => name, :gender => gender, :admit_date => admit_date, :type => type, :breed => breed, :id => id})
  end

  def delete
    DB.exec("DELETE FROM animals WHERE id = #{@id};")
  end

  def save
    result = DB.exec("INSERT INTO animals (name, gender, admit_date, type, breed) VALUES ('#{@name}', '#{@gender}', '#{@admit_date}', '#{@type}', '#{@breed}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end
  def update(name, type, breed)
    @name = name
    @type = type
    @breed = breed
    DB.exec("UPDATE animals SET name = '#{name}, #{type}, #{breed}' WHERE id = #{id};")
  end
end

