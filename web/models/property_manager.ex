defmodule LordCore.PropertyManager do
  use LordCore.Web, :model

  schema "property_managers" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :phone_number, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string
    belongs_to :company, LordCore.Company

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, ~w(email first_name last_name), [])
    |> validate_required([:email, :first_name, :last_name])
  end

  def registration_changeset(model, params) do
    model
    |> changeset(params)
    |> cast(params, ~w(password), [])
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
