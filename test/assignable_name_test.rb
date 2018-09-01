require 'active_support'
require 'active_support/testing/autorun'

require 'name_of_person/assignable_name'

class StructPerson < Struct.new(:first_name, :last_name)
  include NameOfPerson::AssignableName
end

class AssignableNameTest < ActiveSupport::TestCase
  include NameOfPerson

  setup do
    @person = StructPerson.new("David", "Heinemeier Hansson")
  end

  test "reading name" do
    assert_equal PersonName.new("David", "Heinemeier Hansson"), @person.name
  end

  test "writing name" do
    @person.name = PersonName.new("Jason", "Fried")
    assert_equal PersonName.new("Jason", "Fried"), @person.name
  end
end
