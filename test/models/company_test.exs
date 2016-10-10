defmodule LordCore.CompanyTest do
  use LordCore.ModelCase

  alias LordCore.Company

  @valid_attrs %{address: "some content", name: "some content", phone_number: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Company.changeset(%Company{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Company.changeset(%Company{}, @invalid_attrs)
    refute changeset.valid?
  end
end
