defmodule LordCoreWeb.PropertyView do
  use LordCoreWeb, :view
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
