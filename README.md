# Name of Person

Presenting names for English-language applications where a basic model of first and last name(s) combined is sufficient. This approach is not meant to cover all possible naming cases, deal with other languages, or even titulations. Just the basics.

## Examples

```ruby
# Relies on Person having a schema with first_name and last_name columns.
class Person < ApplicationRecord
  has_person_name
end

# Saves a new record using { first_name: "David", last_name: "Heinemeier Hansson" }
person = Person.create! name: "David Heinemeier Hansson"

person.name.full        # => "David Heinemeier Hansson"
person.name.first       # => "David"
person.name.last        # => "Heinemeier Hansson"
person.name.initials    # => "DHH"
person.name.familiar    # => "David H."
person.name.abbreviated # => "D. Heinemeier Hansson"
person.name.sorted      # => "Heinemeier Hansson, David"
person.name.mentionable # => "davidh"
person.name.possessive  # => "David Heinemeier Hansson's"

# Use directly
name = NameOfPerson::PersonName.full("David Heinemeier Hansson")
name.first # => "David"
```

## Installation

```ruby
# Gemfile
gem 'name_of_person'
```

If you are using this outside of Rails, make sure `ActiveRecord` and/or `ActiveModel` are manually required.

```ruby
require 'active_record'
# and/or
require 'active_model'
```

## Maintenance Expectations

This library is an extraction from Basecamp that's been sufficient in almost unaltered form for over 10 years. While contributions are always welcome, do not expect a lot of feature evolution beyond the basics. Feel free to fork this library if you'd like to add large upgrades like titulations or different accommodations for other languages.

## License

Name of Person is released under the [MIT License](https://opensource.org/licenses/MIT).
