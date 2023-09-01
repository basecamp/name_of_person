ActiveSupport.on_load(:active_record) do
  include NameOfPerson::HasPersonName
end
