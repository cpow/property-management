defmodule LordCore.PropertyManagementDashboardController do
  use LordCore.Web, :controller

  import LordCore.AuthorizeByRole
  plug :authorize, %{role: "Property Manager", admin: false}

  alias LordCore.Repo
  alias LordCore.Company

  def index(conn, _) do
    user = conn.assigns.current_user
    company = Repo.get(Company, user.company_id) |> Repo.preload(:properties)

    conn
    |> render("index.html", %{user: user, company: company})
  end
end
