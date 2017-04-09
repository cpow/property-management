defmodule LordCore.Property do
  use LordCore.Web, :model

  schema "properties" do
    field :name, :string
    field :address, :string
    field :city, :string
    field :state, :string
    field :zip, :string
    has_many :units, LordCore.Unit
    belongs_to :company, LordCore.Company

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :address, :city, :state, :zip])
    |> validate_required([:name, :address, :city, :state, :zip])
  end
end
