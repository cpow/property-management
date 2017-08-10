defmodule LordCoreWeb.LegalEntityControllerTest do
  use LordCoreWeb.ConnCase

  alias LordCore.StripeAccounts
  alias LordCore.StripeAccounts.LegalEntity

  @create_attrs %{first_name: "some first_name", last_name: "some last_name", type: "some type"}
  @update_attrs %{first_name: "some updated first_name", last_name: "some updated last_name", type: "some updated type"}
  @invalid_attrs %{first_name: nil, last_name: nil, type: nil}

  def fixture(:legal_entity) do
    {:ok, legal_entity} = StripeAccounts.create_legal_entity(@create_attrs)
    legal_entity
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all legal_entities", %{conn: conn} do
      conn = get conn, legal_entity_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create legal_entity" do
    test "renders legal_entity when data is valid", %{conn: conn} do
      conn = post conn, legal_entity_path(conn, :create), legal_entity: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, legal_entity_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "first_name" => "some first_name",
        "last_name" => "some last_name",
        "type" => "some type"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, legal_entity_path(conn, :create), legal_entity: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update legal_entity" do
    setup [:create_legal_entity]

    test "renders legal_entity when data is valid", %{conn: conn, legal_entity: %LegalEntity{id: id} = legal_entity} do
      conn = put conn, legal_entity_path(conn, :update, legal_entity), legal_entity: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, legal_entity_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "first_name" => "some updated first_name",
        "last_name" => "some updated last_name",
        "type" => "some updated type"}
    end

    test "renders errors when data is invalid", %{conn: conn, legal_entity: legal_entity} do
      conn = put conn, legal_entity_path(conn, :update, legal_entity), legal_entity: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete legal_entity" do
    setup [:create_legal_entity]

    test "deletes chosen legal_entity", %{conn: conn, legal_entity: legal_entity} do
      conn = delete conn, legal_entity_path(conn, :delete, legal_entity)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, legal_entity_path(conn, :show, legal_entity)
      end
    end
  end

  defp create_legal_entity(_) do
    legal_entity = fixture(:legal_entity)
    {:ok, legal_entity: legal_entity}
  end
end
