defmodule LordCore.PropertyView do
  use LordCore.Web, :view
  use JaSerializer.PhoenixView

  attributes [
    :name,
    :address,
    :city,
    :state,
    :zip
  ]

  has_many :units, serializer: LordCore.UnitView
end
