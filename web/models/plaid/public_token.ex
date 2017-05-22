defmodule LordCore.Plaid.PublicToken do
  defstruct public_endpoint: "https://sandbox.plaid.com/item/public_token/exchange",
    client_id: Application.get_env(:lord_core, :plaid)[:client_id],
    secret: Application.get_env(:lord_core, :plaid)[:secret]
end
