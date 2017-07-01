defmodule LordCore.PropertyTest do
  use LordCore.ModelCase

  alias LordCore.Property

  @valid_attrs %{address: "some content", city: "some content", name: "some content", state: "some content", zip: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Property.changeset(%Property{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Property.changeset(%Property{}, @invalid_attrs)
    refute changeset.valid?
  end
end
