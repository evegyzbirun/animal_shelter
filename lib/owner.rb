class Owner
  attr_reader :id
  attr_accessor :name

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def ==(owner_to_compare)
    (self.name == owner_to_compare.name) && (self.id == owner_to_compare.id)
  end

  def self.all
    returned_owners = DB.exec("SELECT * FROM owners;")
    owners = []
    returned_owners.each do |owner|
      name = owner.fetch("name")
      id = owner.fetch("id").to_i
      owners.push(Owner.new({:name => name, :id => id}))
    end
    owners
  end

  def self.clear
    DB.exec("DELETE FROM owners *;")
  end
  
  def self.find(id)
  owner = DB.exec("SELECT * FROM owners WHERE id = #{id};").first
  name = owner.fetch("name")
  id = owner.fetch("id").to_i
  Owner.new({:name => name, :id => id})
  end

  def save
    result = DB.exec("INSERT INTO owners (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def delete
    DB. exec("DELETE FROM owners WHERE id = #{@id};")
  end

  def update(name)
    @name = name
    DB.exec("UPDATE owners SET name = '#{@name}' WHERE id =#{id};")
  end
end