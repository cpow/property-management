defmodule LordCore.CompanyView do
  use LordCore.Web, :view
  use JaSerializer.PhoenixView

  attributes [
    :name
  ]

  has_many :users, serializer: LordCore.UserView
  has_many :properties,
    serializer: LordCore.PropertyView,
    links: [
      related: "/api/v1/companies/:id/properties"
    ]

  has_many :properties, serializer: LordCore.PropertyView
end
