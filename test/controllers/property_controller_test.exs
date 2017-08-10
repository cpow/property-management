defmodule LordCore.PropertyControllerTest do
  use LordCoreWeb.ConnCase
  alias LordCore.Property

  @valid_attrs %{
    address: "some content",
    city: "some content",
    name: "some content",
    state: "some content",
    zip: "some content"
  }
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists only the current user's company's properties on index", %{conn: conn} do
    user = Guardian.Plug.current_resource(conn)
    property = insert(:property, company: user.company)
    insert(:property, name: "NOT GUNNA BE HERE")

    conn = get conn, property_path(conn, :index)
    assert json_response(conn, 200) == rendered_index([property])
  end

  test "doesn't list anything if current user has no properties", %{conn: conn} do
    insert(:property)

    conn = get conn, property_path(conn, :index)
    assert json_response(conn, 200) == rendered_index([])
  end

  test "shows chosen resource", %{conn: conn} do
    user = Guardian.Plug.current_resource(conn)
    property = insert(:property, company: user.company)
    conn = get conn, property_path(conn, :show, property)
    assert json_response(conn, 200) == rendered_property(property)
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, property_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, property_path(conn, :create),
      data: %{attributes: @valid_attrs}
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Property, @valid_attrs)
  end

  test "adds company of current user to prop when valid", %{conn: conn} do
    user = Guardian.Plug.current_resource(conn)

    conn = post conn, property_path(conn, :create),
      data: %{attributes: @valid_attrs}
    property = Repo.get_by(Property, @valid_attrs)

    assert json_response(conn, 201)["data"]["id"]
    assert property.company_id == user.company_id
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, property_path(conn, :create),
      data: %{attributes: @invalid_attrs}
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    property = Repo.insert! %Property{}
    conn = put conn, property_path(conn, :update, property),
      data: %{attributes: @valid_attrs}
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Property, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    property = Repo.insert! %Property{}
    conn = put conn, property_path(conn, :update, property),
      data: %{attributes: @invalid_attrs}
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    property = Repo.insert! %Property{}
    conn = delete conn, property_path(conn, :delete, property)
    assert response(conn, 204)
    refute Repo.get(Property, property.id)
  end

  defp rendered_index(properties) do
    LordCoreWeb.PropertyView.render("index.json-api", data: properties)
  end

  defp rendered_property(property) do
    LordCoreWeb.PropertyView.render("show.json-api", data: property)
  end
end
