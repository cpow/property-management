defmodule LordCore.User do
  use LordCore.Web, :model

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string
    field :username, :string
    field :first_name, :string
    field :last_name, :string
    field :role, :string
    belongs_to :company, LordCore.Company
    belongs_to :property, LordCore.Property
    belongs_to :unit, LordCore.Unit

    has_one :stripe_account, LordCore.StripeAccount

    timestamps()
  end

  @doc """
  Builds a changeset based on the `model` and `params`.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(
            params,
            ~w(email username first_name last_name company_id property_id role)
            )
    |> validate_required([:email, :username, :first_name, :last_name, :role])
  end

  def registration_changeset(model, params) do
    model
    |> changeset(params)
    |> cast(params, ~w(password role email first_name last_name company_id))
    |> validate_required([:role, :email, :first_name, :last_name])
    |> validate_length(:password, min: 6, max: 100)
    |> validate_confirmation(:password, message: "does not match password")
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
