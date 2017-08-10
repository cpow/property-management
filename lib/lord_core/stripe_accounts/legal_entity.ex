defmodule LordCore.StripeAccounts.LegalEntity do
  use Ecto.Schema
  import Ecto.Changeset
  alias LordCore.StripeAccounts.LegalEntity


  schema "legal_entities" do
    field :first_name, :string
    field :last_name, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(%LegalEntity{} = legal_entity, attrs) do
    legal_entity
    |> cast(attrs, [:first_name, :last_name, :type])
    |> validate_required([:first_name, :last_name, :type])
  end
end
