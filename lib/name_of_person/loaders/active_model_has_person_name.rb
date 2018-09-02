begin
  require 'active_model'
  require 'name_of_person/has_person_name'

  require 'active_model/model'
  ActiveModel::Model.send :include, NameOfPerson::HasPersonName
rescue LoadError
  # Active Model won't be auto-configured with has_person_name
end
