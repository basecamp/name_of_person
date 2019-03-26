require 'active_support'
require 'active_support/testing/autorun'

require 'active_model'
require 'name_of_person'

class ModelPerson
  include ActiveModel::Model
  attr_accessor :first_name, :last_name

  has_person_name
end

class HasPersonNameTest < ActiveSupport::TestCase
  include NameOfPerson

  setup do
    @person = ModelPerson.new(first_name: "David", last_name: "Heinemeier Hansson")
  end

  test "reading name" do
    assert_equal PersonName.new("David", "Heinemeier Hansson"), @person.name
  end

  test "writing name" do
    @person.name = PersonName.new("Jason", "Fried")
    assert_equal PersonName.new("Jason", "Fried"), @person.name
  end
end
