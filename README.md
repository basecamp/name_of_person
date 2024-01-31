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
person.name.possessive(:first)  # => "David's"
person.name.possessive(:last)  # => "Hansson's"
person.name.possessive(:initials)  # => "DHH's"
person.name.possessive(:sorted)  # => "Heinemeier Hansson, David's"
person.name.possessive(:abbreviated)  # => "D. Heinemeier Hansson's"


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

## Run tests with

`bundle exec rake test`

## No further development is going to happen

This gem is essentially frozen, as the developers have decided to only deal with full names going forward in their applications. Feel free to fork this work, brand it under a new name, and continue development.

## License

Name of Person is released under the [MIT License](https://opensource.org/licenses/MIT).
