class UserRole < EnumerateIt::Base
  associate_values(
    :default,
    :admin
  )
end
