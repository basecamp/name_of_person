require 'name_of_person/assignable_name'

module NameOfPerson
  module HasPersonName
    extend ActiveSupport::Concern

    class_methods do
      # Defines the instance methods name/name= from AssignableName.
      def has_person_name
        include NameOfPerson::AssignableName
      end
    end
  end
end
