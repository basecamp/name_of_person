require 'name_of_person/person_name'

module NameOfPerson
  module AssignableName
    # Assigns first_name and last_name attributes as extracted from a supplied full name.
    def name=(name)
      full_name = NameOfPerson::PersonName.full(name)
      self.first_name, self.last_name = full_name&.first, full_name&.last
    end

    # Returns a PersonName object created from the first_name and last_name attributes.
    def name
      NameOfPerson::PersonName.new(first_name, last_name) if first_name
    end
  end
end
