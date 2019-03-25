if defined?(ActiveModel)
  ActiveModel::Model.send :include, NameOfPerson::HasPersonName
end
