defmodule LordCore.AuthorizeByRole do
  import Plug.Conn

  def authorize(conn=%Plug.Conn{assigns: %{current_user: nil}}, _) do
    conn
    |> Phoenix.Controller.put_flash(:error, "Not Logged In. Please login :)")
    |> Phoenix.Controller.redirect(to: "/")
    |> halt()
  end

  def authorize(conn, %{role: role_name, admin: admin}) do
    role = conn.assigns[:role]
    if role.name == role_name && role.admin == admin do
      conn
    else
      conn
      |> Phoenix.Controller.put_flash(:error, "Not Authorized to view that :(")
      |> Phoenix.Controller.redirect(to: "/")
      |> halt()
    end
  end
end
