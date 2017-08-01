defmodule LordCore.Company do
  use LordCore.Web, :model

  schema "companies" do
    field :name, :string
    field :address, :string
    field :phone_number, :string
    has_many :users, LordCore.User
    has_many :properties, LordCore.Property

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :address, :phone_number])
    |> validate_required([:name, :address, :phone_number])
  end
end
