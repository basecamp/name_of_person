if ActiveSupport.gem_version < "7.1.0.alpha"
  ActiveSupport.on_load(:active_model) do
    include NameOfPerson::HasPersonName
  end
else
  if defined?(ActiveModel)
    ActiveModel::Model.send :include, NameOfPerson::HasPersonName
  end
end
