defmodule LordCore.PropertyView do
  use LordCore.Web, :view
  use JaSerializer.PhoenixView

  attributes [
    :name,
    :address,
    :city,
    :zip,
    :company_id,
    :id,
    :state
  ]
end
