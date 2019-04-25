require 'active_support'
require 'active_support/testing/autorun'
require 'yaml'

require 'name_of_person/person_name'

class PersonNameTest < ActiveSupport::TestCase
  include NameOfPerson

  setup do
    @name  = PersonName.new('Foo', 'Bar')
    @first = PersonName.new('Baz')
  end

  test "first is required" do
    assert_raise ArgumentError do
      PersonName.new(nil)
    end
  end

  test "last may be omitted" do
    assert_nothing_raised do
      PersonName.new('Foo', nil)
    end
  end

  test "first and last" do
    assert_equal 'Foo', @name.first
    assert_equal 'Bar', @name.last

    assert_equal 'Baz', @first.first
    assert_nil @first.last
  end

  test "full name" do
    assert_equal 'Foo Bar', @name.full
    assert_equal 'Foo Bar', @name

    assert_equal @first.first, @first.full
    assert_equal @first.first, @first
  end

  test "abbreviations" do
    assert_equal 'Foo B.', @name.familiar
    assert_equal 'F. Bar', @name.abbreviated
    assert_equal 'Bar, Foo', @name.sorted

    assert_equal @first.first, @first.familiar
    assert_equal @first.first, @first.abbreviated
    assert_equal @first.first, @first.sorted
  end

  test "possessive" do
    assert_equal "#{@name.full}'s", @name.possessive
    assert_equal "#{@first.full}'s", @first.possessive
    assert_equal "Foo Bars'", PersonName.new('Foo', 'Bars').possessive
  end

  test "initials" do
    name = PersonName.full('David Heinemeier Hansson')
    assert_equal 'DHH', name.initials
  end

  test "initials (full name with spaces)" do
    name = PersonName.full('  David    Heinemeier   Hansson  ')
    assert_equal 'DHH', name.initials
  end

  test "initials for just a first name" do
    name = PersonName.full('David')
    assert_equal 'D', name.initials
  end

  test "initials skip anything inside parenthesis" do
    name = PersonName.full('Conor Muirhead (Basecamp)')
    assert_equal 'CM', name.initials
  end

  test "initials skip anything inside brackets" do
    name = PersonName.full('Conor Muirhead [Basecamp]')
    assert_equal 'CM', name.initials
  end

  test "initials skip non-word characters" do
    name = PersonName.full('Conor Muirhead !')
    assert_equal 'CM', name.initials
  end

  test "from full name" do
    name = PersonName.full('Will St. Clair')
    assert_equal 'Will', name.first
    assert_equal 'St. Clair', name.last

    first = PersonName.full('Will')
    assert_equal 'Will', first.first
    assert_nil first.last

    assert_nil PersonName.full(nil)
    assert_nil PersonName.full('')
  end

  test "full name with spaces at the edges of the string" do
    name = PersonName.full('  Will St. Clair ')
    assert_equal 'Will', name.first
    assert_equal 'St. Clair', name.last
    assert_equal 'Will St. Clair', name.full
  end

  test "full name with spaces between first and last name" do
    name = PersonName.full('Will   St. Clair')
    assert_equal 'Will', name.first
    assert_equal 'St. Clair', name.last
    assert_equal 'Will St. Clair', name.full
  end

  test "full name with spaces between multiple last name words" do
    name = PersonName.full('Will St.   Clair')
    assert_equal 'Will', name.first
    assert_equal 'St. Clair', name.last
    assert_equal 'Will St. Clair', name.full
  end

  test "full name with spaces everywhere" do
    name = PersonName.full('  Will     St.   Clair       ')
    assert_equal 'Will', name.first
    assert_equal 'St. Clair', name.last
    assert_equal 'Will St. Clair', name.full
  end

  test "blank last name behaves the same as nil" do
    name = PersonName.new('Baz', '')
    assert_equal @first.full, name.full
    assert_equal @first.familiar, name.familiar
    assert_equal @first.abbreviated, name.abbreviated
    assert_equal @first.sorted, name.sorted
    assert_equal @first.possessive, name.possessive
  end

  test "mentionable" do
    assert_equal 'foob', @name.mentionable
  end

  test "mentionable with first name" do
    name = PersonName.full('Will')
    assert_equal 'wil', name.mentionable
  end

  test "mentionable with three names" do
    name = PersonName.full('Will St. Clair')
    assert_equal 'wills', name.mentionable
  end

  test "familiar" do
    assert_equal 'Foo B.', @name.familiar
  end

  test "familiar with three names" do
    name = PersonName.full('Will St. Clair')
    assert_equal 'Will S.', name.familiar
  end

  test "serialize yaml" do
    assert_equal @name, YAML.load(YAML.dump(@name))
    assert_equal @first, YAML.load(YAML.dump(@first))
    assert_equal String, YAML.load(YAML.dump(@name)).class
  end
end
