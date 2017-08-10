defmodule LordCoreWeb.TosAcceptanceControllerTest do
  use LordCoreWeb.ConnCase

  alias LordCore.StripeAccounts
  alias LordCore.StripeAccounts.TosAcceptance

  @create_attrs %{date: ~N[2010-04-17 14:00:00.000000]}
  @update_attrs %{date: ~N[2011-05-18 15:01:01.000000]}
  @invalid_attrs %{date: nil}

  def fixture(:tos_acceptance) do
    {:ok, tos_acceptance} = StripeAccounts.create_tos_acceptance(@create_attrs)
    tos_acceptance
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all tos_acceptances", %{conn: conn} do
      conn = get conn, tos_acceptance_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create tos_acceptance" do
    test "renders tos_acceptance when data is valid", %{conn: conn} do
      conn = post conn, tos_acceptance_path(conn, :create), tos_acceptance: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, tos_acceptance_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "date" => ~N[2010-04-17 14:00:00.000000]}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, tos_acceptance_path(conn, :create), tos_acceptance: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update tos_acceptance" do
    setup [:create_tos_acceptance]

    test "renders tos_acceptance when data is valid", %{conn: conn, tos_acceptance: %TosAcceptance{id: id} = tos_acceptance} do
      conn = put conn, tos_acceptance_path(conn, :update, tos_acceptance), tos_acceptance: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, tos_acceptance_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "date" => ~N[2011-05-18 15:01:01.000000]}
    end

    test "renders errors when data is invalid", %{conn: conn, tos_acceptance: tos_acceptance} do
      conn = put conn, tos_acceptance_path(conn, :update, tos_acceptance), tos_acceptance: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete tos_acceptance" do
    setup [:create_tos_acceptance]

    test "deletes chosen tos_acceptance", %{conn: conn, tos_acceptance: tos_acceptance} do
      conn = delete conn, tos_acceptance_path(conn, :delete, tos_acceptance)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, tos_acceptance_path(conn, :show, tos_acceptance)
      end
    end
  end

  defp create_tos_acceptance(_) do
    tos_acceptance = fixture(:tos_acceptance)
    {:ok, tos_acceptance: tos_acceptance}
  end
end
