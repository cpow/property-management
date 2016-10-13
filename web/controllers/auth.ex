defmodule LordCore.Auth do
  import Plug.Conn
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    case conn.assigns do
      # this case is for testing
      # essentially this is a backdoor for loggin in a user for tests
      %{current_user: %LordCore.User{}} ->
        conn
      _ ->
        user_id = get_session(conn, :user_id)
        if user_id do
          user = repo.get(LordCore.User, user_id)
          conn
          |> assign(:current_user, user)
          |> assign(:role, role_for_user(user))
        else
          conn
          |> assign(:current_user, nil)
          |> assign(:role, %{name: "Not Logged In"})
        end
    end
  end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> assign(:role, role_for_user(user))
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  def login_by_email_and_pass(conn, email, given_pass, opts) do
    repo = Keyword.fetch!(opts, :repo)
    user = repo.get_by(LordCore.User, email: email)

    cond do
      user && checkpw(given_pass, user.password_hash) ->
        {:ok, login(conn, user)}
      user ->
        {:error, :unauthorized, conn}
      true ->
        dummy_checkpw()
        {:error, :not_found, conn}
    end
  end

  def logout(conn) do
    configure_session(conn, drop: true)
  end

  def role_for_user(user) do
    LordCore.Repo.get(LordCore.Role, user.role_id)
  end
end
