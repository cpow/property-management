defmodule LordCore.UserController do
  use LordCore.Web, :controller
  alias LordCore.User

  plug Guardian.Plug.EnsureAuthenticated, [handler: LordCore.AuthErrorHandler] when not action in [:create, :new]

  def index(conn, _params, current_user) do
    users = Repo.all(User)
    render(conn, "index.json-api", data: users)
  end

  def new(conn, _params, current_user) do
    changeset = User.changeset(%User{})
    render(conn, "new.json-api", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}, current_user) do
    changeset = User.registration_changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", user_path(conn, :show, user))
        |> render("show.json-api", data: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(LordCore.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => "me"}, current_user) do
    conn |> render("show.json-api", data: current_user)
  end

  def show(conn, %{"id" => id}, current_user) do
    user = Repo.get!(User, id)
    render(conn, "show.json-api", data: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}, current_user) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        render(conn, "show.json-api", data: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(LordCore.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, current_user) do
    user = Repo.get!(User, id)
    Repo.delete!(user)

    send_resp(conn, :no_content, "")
  end

  def action(conn, _) do apply(__MODULE__, action_name(conn),
   [conn, conn.params, Guardian.Plug.current_resource(conn)])
  end
end
