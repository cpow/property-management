defmodule LordCore.UserView do
  use LordCore.Web, :view
  use JaSerializer.PhoenixView

  attributes [
    :name,
    :email,
    :role
  ]
end
