defmodule LordCore.CompanyControllerTest do
  use LordCore.ConnCase

  alias LordCore.Company
  @valid_attrs %{address: "some content", name: "some content", phone_number: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    manager = insert(:property_manager)

    conn = conn
    |> assign(:current_property_manager, manager)
    |> get(company_path(conn, :index))

    assert html_response(conn, 200) =~ "Listing companies"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, company_path(conn, :new)
    assert html_response(conn, 200) =~ "New company"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, company_path(conn, :create), company: @valid_attrs
    assert redirected_to(conn) == company_path(conn, :index)
    assert Repo.get_by(Company, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, company_path(conn, :create), company: @invalid_attrs
    assert html_response(conn, 200) =~ "New company"
  end

  test "doesn't show when user not logged in", %{conn: conn} do
    company = Repo.insert! %Company{}
    conn = get conn, company_path(conn, :show, company)
    assert html_response(conn, 302)
  end

  test "shows when user is logged in", %{conn: conn} do
    company = Repo.insert! %Company{}
    conn = get conn, company_path(conn, :show, company)
    assert html_response(conn, 302)
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    manager = insert(:property_manager)

    assert_error_sent 404, fn ->
      conn
      |> assign(:current_property_manager, manager)
      |> get(company_path(conn, :show, -1))
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    company = Repo.insert! %Company{}
    conn = get conn, company_path(conn, :edit, company)
    assert html_response(conn, 200) =~ "Edit company"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    company = Repo.insert! %Company{}
    conn = put conn, company_path(conn, :update, company), company: @valid_attrs
    assert redirected_to(conn) == company_path(conn, :show, company)
    assert Repo.get_by(Company, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    company = Repo.insert! %Company{}
    conn = put conn, company_path(conn, :update, company), company: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit company"
  end

  test "deletes chosen resource", %{conn: conn} do
    company = Repo.insert! %Company{}
    conn = delete conn, company_path(conn, :delete, company)
    assert redirected_to(conn) == company_path(conn, :index)
    refute Repo.get(Company, company.id)
  end
end
