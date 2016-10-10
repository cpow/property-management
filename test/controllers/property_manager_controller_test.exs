defmodule LordCore.PropertyManagerControllerTest do
  use LordCore.ConnCase

  alias LordCore.PropertyManager
  @valid_attrs %{
    email: "some content",
    first_name: "some content",
    last_name: "some content",
    password: "something",
    password_confirmation: "something",
  }

  @findable_attrs Map.drop(@valid_attrs, [:password,
                                            :password_confirmation,
                                            :password_hash
                                         ])
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, property_manager_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing property managers"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, property_manager_path(conn, :new)
    assert html_response(conn, 200) =~ "New property manager"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, property_manager_path(conn, :create), property_manager: @valid_attrs
    assert redirected_to(conn) == property_manager_path(conn, :index)
    assert Repo.get_by(PropertyManager, @findable_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, property_manager_path(conn, :create), property_manager: @invalid_attrs
    assert html_response(conn, 200) =~ "New property manager"
  end

  test "shows chosen resource", %{conn: conn} do
    property_manager = Repo.insert! %PropertyManager{}
    conn = get conn, property_manager_path(conn, :show, property_manager)
    assert html_response(conn, 200) =~ "Show property manager"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, property_manager_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    property_manager = Repo.insert! %PropertyManager{}
    conn = get conn, property_manager_path(conn, :edit, property_manager)
    assert html_response(conn, 200) =~ "Edit property manager"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    property_manager = Repo.insert! %PropertyManager{}
    conn = put conn, property_manager_path(conn, :update, property_manager), property_manager: @valid_attrs
    assert redirected_to(conn) == property_manager_path(conn, :show, property_manager)
    assert Repo.get_by(PropertyManager, @findable_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    property_manager = Repo.insert! %PropertyManager{}
    conn = put conn, property_manager_path(conn, :update, property_manager), property_manager: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit property manager"
  end

  test "deletes chosen resource", %{conn: conn} do
    property_manager = Repo.insert! %PropertyManager{}
    conn = delete conn, property_manager_path(conn, :delete, property_manager)
    assert redirected_to(conn) == property_manager_path(conn, :index)
    refute Repo.get(PropertyManager, property_manager.id)
  end
end
