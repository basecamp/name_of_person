require 'activesupport/test_case'

class PersonNameTest < ActiveSupport:TestCase
  def setup
    @name = SignalId::PersonName.new('Foo', 'Bar')
    @first = SignalId::PersonName.new('Baz')
  end

  test "first is required" do
    assert_raise ArgumentError do
      SignalId::PersonName.new(nil)
    end
  end

  test "last may be omitted" do
    assert_nothing_raised do
      SignalId::PersonName.new('Foo', nil)
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
    assert_equal "Foo Bars'", SignalId::PersonName.new('Foo', 'Bars').possessive
  end

  test "from full name" do
    name = SignalId::PersonName.full('Will St. Clair')
    assert_equal 'Will', name.first
    assert_equal 'St. Clair', name.last

    first = SignalId::PersonName.full('Will')
    assert_equal 'Will', first.first
    assert_nil first.last

    assert_nil SignalId::PersonName.full(nil)
    assert_nil SignalId::PersonName.full('')
  end

  test "blank last name behaves the same as nil" do
    name = SignalId::PersonName.new('Baz', '')
    assert_equal @first.full, name.full
    assert_equal @first.familiar, name.familiar
    assert_equal @first.abbreviated, name.abbreviated
    assert_equal @first.sorted, name.sorted
    assert_equal @first.possessive, name.possessive
  end

  test "mentionable" do
    assert_equal 'foob', @name.mentionable
  end

  test "mentionable with three names" do
    name = SignalId::PersonName.full('Will St. Clair')
    assert_equal 'wills', name.mentionable
  end

  test "familiar" do
    assert_equal 'Foo B.', @name.familiar
  end

  test "familiar with three names" do
    name = SignalId::PersonName.full('Will St. Clair')
    assert_equal 'Will S.', name.familiar
  end

  test "serialize yaml" do
    assert_equal @name, YAML.load(YAML.dump(@name))
    assert_equal @first, YAML.load(YAML.dump(@first))
    assert_equal String, YAML.load(YAML.dump(@name)).class
  end
end