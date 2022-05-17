class Customer
  attr_reader :id
  attr_accessor :name, :type_pref, :breed_pref

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @type_pref = attributes.fetch(:type_pref)
    @breed_pref = attributes.fetch(:breed_pref)
    @id = attributes.fetch(:id)
  end
  
  def self.all
    returned_customers = DB.exec("SELECT * FROM customers;")
    customers = []
    returned_customers.each do |customer|
      name = customer.fetch("name")
      type_pref = customer.fetch("type_pref")
      breed_pref = customer.fetch("breed_pref")
      id = customer.fetch("id").to_i
      customers.push(Customer.new({:name => name, :type_pref => type_pref, :breed_pref => breed_pref, :id => id}))
    end
    customers
  end

  def self.find(id)
    customer = DB.exec("SELECT * FROM customers WHERE id = #{id};").first
    name = customer.fetch("name")
    type_pref = customer.fetch("type_pref")
    breed_pref = customer.fetch("breed_pref")
    id = customer.fetch("id").to_i
    Customer.new({:name => name, :type_pref => type_pref, :breed_pref => breed_pref, :id => id})
  end
  
  def ==(customer_to_compare)
    (self.name == customer_to_compare.name) && (self.id == customer_to_compare.id)
  end

  def self.clear
    DB.exec("DELETE FROM customers *;")
  end

  def delete
    DB.exec("DELETE FROM customers WHERE id = #{@id};")
  end

  def save
    result = DB.exec("INSERT INTO customers (name, type_pref, breed_pref) VALUES ('#{@name}', '#{@type_pref}', '#{@breed_pref}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def update(name, type_pref, breed_pref)
    @name = name
    @type_pref = type_pref
    @breed_pref = breed_pref
    DB.exec("UPDATE customers SET name = '#{name}, #{type_pref}, #{breed_pref}' WHERE id = #{id};")
  end
end


