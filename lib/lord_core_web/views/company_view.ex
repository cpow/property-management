defmodule LordCoreWeb.CompanyView do
  use LordCore.Web, :view
  use JaSerializer.PhoenixView

  attributes [
    :name
  ]

  has_many :users, serializer: LordCoreWeb.UserView
  has_many :properties,
    serializer: LordCoreWeb.PropertyView,
    links: [
      related: "/api/v1/companies/:id/properties"
    ]

  has_many :properties, serializer: LordCoreWeb.PropertyView
end
