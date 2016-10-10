defmodule LordCore.PropertyManagerTest do
  use LordCore.ModelCase

  alias LordCore.PropertyManager

  @valid_attrs %{email: "some content", first_name: "some content", last_name: "some content", phone_number: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PropertyManager.changeset(%PropertyManager{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PropertyManager.changeset(%PropertyManager{}, @invalid_attrs)
    refute changeset.valid?
  end
end
