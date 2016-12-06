defmodule LordCore.SessionController do
  import Plug.Conn
  use LordCore.Web, :controller

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"email" => email, "password" => pass}}) do
    case LordCore.Auth.login_by_email_and_pass(conn, email, pass, repo: Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome Back! #{conn.assigns.current_user.first_name}")
        |> redirect(to: page_path(conn, :index))
      {:error, _reson, conn} ->
        conn
        |> put_flash(:error, "Invalid username or password")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> LordCore.Auth.logout()
    |> redirect(to: page_path(conn, :index))
  end
end
