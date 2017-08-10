defmodule LordCoreWeb.ExternalAccountControllerTest do
  use LordCoreWeb.ConnCase

  alias LordCore.StripeAccounts
  alias LordCore.StripeAccounts.ExternalAccount

  @create_attrs %{token: "some token"}
  @update_attrs %{token: "some updated token"}
  @invalid_attrs %{token: nil}

  def fixture(:external_account) do
    {:ok, external_account} = StripeAccounts.create_external_account(@create_attrs)
    external_account
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all external_accounts", %{conn: conn} do
      conn = get conn, external_account_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create external_account" do
    test "renders external_account when data is valid", %{conn: conn} do
      conn = post conn, external_account_path(conn, :create), external_account: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, external_account_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "token" => "some token"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, external_account_path(conn, :create), external_account: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update external_account" do
    setup [:create_external_account]

    test "renders external_account when data is valid", %{conn: conn, external_account: %ExternalAccount{id: id} = external_account} do
      conn = put conn, external_account_path(conn, :update, external_account), external_account: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, external_account_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "token" => "some updated token"}
    end

    test "renders errors when data is invalid", %{conn: conn, external_account: external_account} do
      conn = put conn, external_account_path(conn, :update, external_account), external_account: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete external_account" do
    setup [:create_external_account]

    test "deletes chosen external_account", %{conn: conn, external_account: external_account} do
      conn = delete conn, external_account_path(conn, :delete, external_account)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, external_account_path(conn, :show, external_account)
      end
    end
  end

  defp create_external_account(_) do
    external_account = fixture(:external_account)
    {:ok, external_account: external_account}
  end
end
