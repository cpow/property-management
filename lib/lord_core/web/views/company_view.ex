defmodule LordCore.Web.CompanyView do
  use LordCore.Web, :view
  use JaSerializer.PhoenixView

  attributes [
    :name
  ]

  has_many :users, serializer: LordCore.Web.UserView
  has_many :properties,
    serializer: LordCore.Web.PropertyView,
    links: [
      related: "/api/v1/companies/:id/properties"
    ]

  has_many :properties, serializer: LordCore.Web.PropertyView
end
