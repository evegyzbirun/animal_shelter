require 'spec_helper'

describe('#Owner') do

  before(:each) do
    @own1 = Owner.new({name: "bill", id: nil})
    @own1.save
    @own2 = Owner.new({name: "sam", id: nil})
    @own2.save
  end

  describe('#==') do
    it('is the same owner if has the same attributes as another') do
      own1 = Owner.new({name: "bill", id: nil})
      own2 = Owner.new({name: "bill", id: nil})
      expect(own1).to(eq(own2))
    end
  end

  describe('.all') do
    it('returns an empty array when there are no owners') do
      Owner.clear
      expect(Owner.all).to(eq([]))
    end
  end

  describe('#save') do
    it('saves an owner to the database') do
      expect(Owner.all).to(eq([@own1, @own2]))
    end
  end

  describe('.find') do
    it('finds an Owner by its id') do
      expect(Owner.find(@own1.id)).to(eq(@own1))
    end
  end

  describe('#update') do
    it('updates an Owner by their id') do
      @own1.update("jack")
      expect(@own1.name).to(eq("jack"))
    end
  end

  describe('#delete') do
    it('deletes an Owner by their id') do
      @own1.delete
      expect(Owner.all).to(eq([@own2]))
    end
  end
end