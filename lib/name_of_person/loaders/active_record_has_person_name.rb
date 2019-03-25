if defined?(ActiveRecord)
  ActiveRecord::Base.send :include, NameOfPerson::HasPersonName
end
