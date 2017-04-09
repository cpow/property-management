defmodule LordCore.UserView do
  use LordCore.Web, :view
  use JaSerializer.PhoenixView

  attributes [
    :name,
    :email,
    :role
  ]

  has_one :company,
    include: false,
    serializer:  LordCore.CompanyView,
    type: "company",
    field: :company_id

end
