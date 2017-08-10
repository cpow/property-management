defmodule LordCore.StripeAccounts.TosAcceptance do
  use Ecto.Schema
  import Ecto.Changeset
  alias LordCore.StripeAccounts.TosAcceptance


  schema "tos_acceptances" do
    field :date, :utc_datetime
    field :ip, :string

    timestamps()
  end

  @doc false
  def changeset(%TosAcceptance{} = tos_acceptance, attrs) do
    tos_acceptance
    |> cast(attrs, [:date, :ip])
    |> validate_required([:date, :ip])
  end
end
