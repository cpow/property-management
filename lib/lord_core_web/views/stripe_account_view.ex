defmodule LordCoreWeb.StripeAccountView do
  use LordCore.Web, :view
  use JaSerializer.PhoenixView

  attributes [
    :account_id,
    :user_id
  ]
end
