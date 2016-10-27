defmodule LordCore.PageController do
  use LordCore.Web, :controller

  def index(conn, _params) do
    case conn.assigns[:role] do
      %LordCore.Role{name: "Property Manager"} ->
        conn
        |> redirect(to: property_management_dashboard_path(conn, :index))
      %LordCore.Role{name: "Tenant"} ->
        conn
        |> redirect(to: tenant_dashboard_path(conn, :index))
      _ ->
        render conn, "index.html"
    end
  end
end
