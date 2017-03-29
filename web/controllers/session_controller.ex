defmodule LordCore.SessionController do
  import Plug.Conn
  use LordCore.Web, :controller

  alias LordCore.{Repo, User}

  def create(conn, %{"email" => email, "password" => password}) do
    case Repo.get_by(User, email: email) do
      nil ->
        Comeonin.Bcrypt.dummy_checkpw
        login_failed(conn)
      user ->
        if Comeonin.Bcrypt.checkpw(password, user.password_hash) do
          {:ok, token, _} = Guardian.encode_and_sign(user, :api)
          render(conn, "token.json", %{token: token})
        else
          login_failed(conn)
        end
    end
  end

  defp login_failed(conn) do
    conn
    |> render("login_failed.json", %{})
    |> halt
  end
end
