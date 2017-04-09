defmodule LordCore.UnitTest do
  use LordCore.ModelCase

  alias LordCore.Unit

  @valid_attrs %{unit_number: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Unit.changeset(%Unit{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Unit.changeset(%Unit{}, @invalid_attrs)
    refute changeset.valid?
  end
end
