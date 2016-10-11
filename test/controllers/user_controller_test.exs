defmodule LordCore.UserControllerTest do
  use LordCore.ConnCase

  alias LordCore.User

  @invalid_attrs %{}

  setup do
    role = insert(:role)

    %{
      conn: build_conn(),
      user:
      %{
        email: "some content",
        first_name: "some content",
        last_name: "some content",
        username: "some content",
        password: "something",
        password_confirmation: "something",
        role_id: role.id
      }
    }
  end

  test "lists all entries on index", %{conn: conn, user: _user} do
    conn = get conn, user_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing users"
  end

  test "renders form for new resources", %{conn: conn, user: _user} do
    conn = get conn, user_path(conn, :new)
    assert html_response(conn, 200) =~ "New user"
  end

  test "creates resource and redirects when data is valid", %{conn: conn, user: user} do
    conn = post conn, user_path(conn, :create), user: user
    assert redirected_to(conn) == user_path(conn, :index)
    assert Repo.get_by(User, %{email: user.email})
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn, user: _user} do
    conn = post conn, user_path(conn, :create), user: %{}
    assert html_response(conn, 200) =~ "New user"
  end

  test "shows chosen resource", %{conn: conn, user: _user} do
    user = Repo.insert! %User{}
    conn = get conn, user_path(conn, :show, user)
    assert html_response(conn, 200) =~ "Show user"
  end

  test "renders page not found when id is nonexistent", %{conn: conn, user: _user} do
    assert_error_sent 404, fn ->
      get conn, user_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn, user: _user} do
    user = Repo.insert! %User{}
    conn = get conn, user_path(conn, :edit, user)
    assert html_response(conn, 200) =~ "Edit user"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn, user: user} do
    first_user = Repo.insert! %User{}
    conn = put conn, user_path(conn, :update, first_user), user: user
    assert redirected_to(conn) == user_path(conn, :show, first_user)
    assert Repo.get_by(User, %{email: user.email})
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn, user: _user} do
    user = Repo.insert! %User{}
    conn = put conn, user_path(conn, :update, user), user: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit user"
  end

  test "deletes chosen resource", %{conn: conn, user: _user} do
    user = Repo.insert! %User{}
    conn = delete conn, user_path(conn, :delete, user)
    assert redirected_to(conn) == user_path(conn, :index)
    refute Repo.get(User, user.id)
  end
end
