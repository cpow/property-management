defmodule LordCoreWeb.StripeAccountView do
  use LordCoreWeb, :view
  use JaSerializer.PhoenixView

  attributes [
    :account_id,
    :user_id
  ]
end
