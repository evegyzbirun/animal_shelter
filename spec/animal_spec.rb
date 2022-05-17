require 'spec_helper'

describe('#Animal') do

  before(:each) do
    @animal = Animal.new({name: "spot", gender: "male", admit_date: "2022-04-22", type: "dog", breed: "corgi", id: nil})
    @animal.save
    @animal2 = Animal.new({name: "bill", gender: "male", admit_date: "2022-05-22", type: "cat", breed: "tabby", id: nil})
    @animal2.save
  end

  describe('#==') do
    it('is the same animal if has the same attributes as another') do
      animal = Animal.new(name: "spot", gender: "male", admit_date: 2022-04-22, type: "dog", breed: "corgi", id: nil)
      animal2 = Animal.new(name: "spot", gender: "male", admit_date: 2022-04-22, type: "dog", breed: "corgi", id: nil)
      expect(animal).to(eq(animal2))
    end
  end

  describe('.all') do
    it('returns an empty array when there are no animals') do
      Animal.clear
      expect(Animal.all).to(eq([]))
    end
  end

  describe('#save') do
    it('saves an animal to the database') do
      expect(Animal.all).to(eq([@animal, @animal2]))
    end
  end

  describe('.find') do
    it('finds an animal by its id') do
      expect(Animal.find(@animal.id)).to(eq(@animal))
    end
  end

  describe('#update') do
    it('updates an animal by its id') do
      @animal.update("jack", "cat", "tabby")
      expect(@animal.name).to(eq("jack"))
      expect(@animal.type).to(eq("cat"))
      expect(@animal.breed).to(eq("tabby"))
    end
  end

  describe('#delete') do
    it('deletes an animal by its id') do
      @animal.delete
      expect(Animal.all).to(eq([@animal2]))
    end
  end
end