defmodule LordCore.Unit do
  use LordCore.Web, :model

  schema "units" do
    field :unit_number, :string
    belongs_to :property, LordCore.Property

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:unit_number])
    |> validate_required([:unit_number])
  end
end
