require 'activemodel/base'

module NameOfPerson
  module HasPersonName
    # Defines the instance methods name/name= from AssignableName.
    def has_person_name
      include AssignableName
    end
  end
end

ActiveModel::Base.extend NameOfPerson::HasPersonName
