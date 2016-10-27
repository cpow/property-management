defmodule LordCore.TenantDashboardController do
  use LordCore.Web, :controller

  import LordCore.AuthorizeByRole
  plug :authorize, %{role: "Tenant", admin: false}

  alias LordCore.Repo
  alias LordCore.Property

  def index(conn, _params) do
    user = conn.assigns.current_user
    cond do
      user.property_id != nil ->
        property = Repo.get(Property, user.property_id)
        conn
        |> render("index.html", %{user: user, property: property})
      true ->
        conn
        |> render("no_property.html")
    end

  end
end
