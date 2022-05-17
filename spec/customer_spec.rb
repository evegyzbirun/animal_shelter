require 'spec_helper'

describe('#Customer') do

  before(:each) do
    @cust1 = Customer.new({name: "bill", type_pref: "dog", breed_pref: "husky", id: nil})
    @cust1.save
    @cust2 = Customer.new({name: "sam", type_pref: "cat", breed_pref: "tabby", id: nil})
    @cust2.save
  end

  describe('#==') do
    it('is the same customer if has the same attributes as another') do
      cust1 = Customer.new({name: "bill", type_pref: "dog", breed_pref: "husky", id: nil})
      cust2 = Customer.new({name: "bill", type_pref: "dog", breed_pref: "husky", id: nil})
      expect(cust1).to(eq(cust2))
    end
  end

  describe('.all') do
    it('returns an empty array when there are no customers') do
      Customer.clear
      expect(Customer.all).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a customer to the database') do
      expect(Customer.all).to(eq([@cust1, @cust2]))
    end
  end

  describe('.find') do
    it('finds a customer by its id') do
      expect(Customer.find(@cust1.id)).to(eq(@cust1))
    end
  end

  describe('#update') do
    it('updates a customer by their id') do
      @cust1.update("jack", "cat", "tabby")
      expect(@cust1.name).to(eq("jack"))
      expect(@cust1.type_pref).to(eq("cat"))
      expect(@cust1.breed_pref).to(eq("tabby"))
    end
  end

  describe('#delete') do
    it('deletes a customer by their id') do
      @cust1.delete
      expect(Customer.all).to(eq([@cust2]))
    end
  end
end