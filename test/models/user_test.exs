defmodule LordCore.UserTest do
  use LordCore.ModelCase

  alias LordCore.User

  @valid_attrs %{
    email: "some content",
    first_name: "some content",
    last_name: "some content",
    password: "some content",
    username: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "registration changeset will add password hash" do
    changeset = User.registration_changeset(%User{}, @valid_attrs)
    assert changeset.valid?
    assert changeset.changes.password_hash !== nil
  end
end
