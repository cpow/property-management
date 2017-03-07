defmodule LordCore.Plugs.AuthorizeByRoleTest do
  use LordCore.ConnCase

  test "redirects if a user is not logged in" do
    conn = build_conn()
           |> get(property_management_dashboard_path(build_conn(), :index))

    assert html_response(conn, 302)
  end

  test "works if user is authorized to view something" do
    role = insert(:role, name: "Property Manager")
    company = insert(:company)
    user = insert(:user, role: role, company: company)

    conn = build_conn()
           |> assign(:current_user, user)
           |> assign(:role, role)

    conn = get(conn, property_management_dashboard_path(conn, :index))

    assert html_response(conn, 200)
  end

  test "redirects if user is not authorized" do
    user = insert(:user)

    conn = build_conn()
           |> assign(:current_user, user)
           |> assign(:role, user.role)

    conn = get(conn, property_management_dashboard_path(conn, :index))

    assert html_response(conn, 302)
  end
end
