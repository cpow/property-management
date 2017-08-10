defmodule LordCore.StripeAccount do
  use LordCoreWeb, :model

  schema "stripe_accounts" do
    field :account_id, :string
    field :secret_key, :string
    field :publishable_key, :string
    field :managed, :boolean, default: true

    belongs_to :user, LordCore.User
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:account_id, :secret_key, :publishable_key, :managed, :user_id])
    |> validate_required([])
  end
end
