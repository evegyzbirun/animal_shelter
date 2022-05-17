require 'rspec'
require 'pry'
require 'pg'
require 'animal'

DB = PG.connect({:dbname => 'animal_shelter_test'})

RSpec.configure do |config|
  config.before(:each) do
    DB.exec('DELETE FROM animals *;')
  end
end