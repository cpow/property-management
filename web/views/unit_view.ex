defmodule LordCore.UnitView do
  use LordCore.Web, :view
  use JaSerializer.PhoenixView

  attributes [
    :unit_number
  ]
end
