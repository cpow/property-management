defmodule LordCore.CompanyControllerTest do
  use LordCore.ConnCase

  alias LordCore.Company
  @valid_attrs %{address: "some content", name: "some content", phone_number: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, company_path(conn, :index)
    assert json_response(conn, 200)["data"] == rendered_index()["data"]
  end

  test "shows chosen resource", %{conn: conn} do
    company = insert(:company)
    conn = get conn, company_path(conn, :show, company)
    assert json_response(conn, 200)["data"] == rendered_company(company)["data"]
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, company_path(conn, :create), company: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Company, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, company_path(conn, :create), company: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    company = Repo.insert! %Company{}
    conn = put conn, company_path(conn, :update, company), company: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Company, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    company = Repo.insert! %Company{}
    conn = put conn, company_path(conn, :update, company), company: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    company = Repo.insert! %Company{}
    conn = delete conn, company_path(conn, :delete, company)
    assert response(conn, 204)
    refute Repo.get(Company, company.id)
  end

  defp rendered_company(company) do
    LordCore.CompanyView.render("show.json-api", data: company)
  end

  defp rendered_index do
    LordCore.CompanyView.render("index.json-api", data: Repo.all(Company))
  end
end
