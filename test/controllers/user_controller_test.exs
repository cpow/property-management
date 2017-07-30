defmodule LordCore.UserControllerTest do
  use LordCoreWeb.ConnCase

  alias LordCore.User

  @invalid_attrs %{}
  @valid_attrs %{email: "test@example.com",
                 first_name: "tophie",
                 last_name: "power",
                 username: "tophie_brown",
                 password: "test1234",
                 password_confirmation: "test1234",
                 role: "tenant"
                }

  test "me should grab current user from guardian", %{conn: conn} do
    user = Guardian.Plug.current_resource(conn)
    conn =
      conn
      |> get(user_path(conn, :show, %User{id: "me"}))

    assert json_response(conn, 200) == rendered_user(user)
  end


  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user_path(conn, :index)
    assert json_response(conn, 200)["data"] == rendered_index()["data"]
  end

  test "shows chosen resource", %{conn: conn} do
    user = insert(:user)
    conn = get conn, user_path(conn, :show, user)
    assert json_response(conn, 200)["data"] == rendered_user(user)["data"]
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(User, %{email: "test@example.com"})
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    user = Repo.insert! %User{}
    conn = put conn, user_path(conn, :update, user), user: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(User, %{email: "test@example.com"})
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    user = Repo.insert! %User{}
    conn = put conn, user_path(conn, :update, user), user: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    user = Repo.insert! %User{}
    conn = delete conn, user_path(conn, :delete, user)
    assert response(conn, 204)
    refute Repo.get(User, user.id)
  end

  defp rendered_user(user) do
    LordCore.UserView.render("show.json-api", data: user)
  end

  defp rendered_index do
    LordCore.UserView.render("index.json-api", data: Repo.all(User))
  end
end
