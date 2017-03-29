defmodule LordCore.CompanyView do
  use LordCore.Web, :view
  use JaSerializer.PhoenixView

  attributes [
    :name
  ]

  has_many :users, serializer: PortalApi.UserView
end
