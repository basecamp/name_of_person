begin
  require 'active_record'
  require 'name_of_person/has_person_name'

  ActiveRecord::Base.send :include, NameOfPerson::HasPersonName
rescue LoadError
  # Active Record won't be auto-configured with has_person_name
end
