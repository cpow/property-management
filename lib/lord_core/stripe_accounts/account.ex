defmodule LordCore.StripeAccounts.Account do
  use Ecto.Schema
  import Ecto.Changeset
  alias LordCore.StripeAccounts.Account


  schema "accounts" do
    field :display_name, :string
    field :email, :string
    field :type, :string
    belongs_to :user, LordCore.User
    belongs_to :company, LordCore.Company

    timestamps()
  end

  @doc false
  def changeset(%Account{} = account, attrs) do
    account
    |> cast(attrs, [:email, :type, :display_name, :user_id, :company_id])
    |> validate_required([:email, :type, :display_name])
  end
end
