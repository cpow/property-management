defmodule LordCore.StripeAccounts.ExternalAccount do
  use Ecto.Schema
  import Ecto.Changeset
  alias LordCore.StripeAccounts.ExternalAccount


  schema "external_accounts" do
    field :token, :string

    timestamps()
  end

  @doc false
  def changeset(%ExternalAccount{} = external_account, attrs) do
    external_account
    |> cast(attrs, [:token])
    |> validate_required([:token])
  end
end
