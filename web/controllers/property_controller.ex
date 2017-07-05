defmodule LordCore.PropertyController do
  use LordCore.Web, :controller
  import Ecto.Query, only: [from: 2]
  alias LordCore.Property
  require IEx

  plug Guardian.Plug.EnsureAuthenticated, [handler: LordCore.AuthErrorHandler]

  def index(conn, _params, current_user) do
    query = base_query(current_user)

    properties = Repo.all(query)
    render(conn, "index.json-api", data: properties)
  end

  def create(conn, %{"property" => property_params}, current_user) do
    Map.put(property_params, "company_id", current_user.company_id)
    changeset = Property.changeset(%Property{}, property_params)

    case Repo.insert(changeset) do
      {:ok, property} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", property_path(conn, :show, property))
        |> render("show.json-api", data: property)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(LordCore.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, current_user) do
    property = Repo.get!(base_query(current_user), id)
    render(conn, "show.json-api", data: property)
  end

  def update(conn, %{"id" => id, "property" => property_params}, _current_user) do
    property = Repo.get!(Property, id)
    changeset = Property.changeset(property, property_params)

    case Repo.update(changeset) do
      {:ok, property} ->
        render(conn, "show.json-api", data: property)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(LordCore.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, _current_user) do
    property = Repo.get!(Property, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(property)

    send_resp(conn, :no_content, "")
  end

  def base_query(current_user) do
    from p in Property, where: p.company_id == ^current_user.company_id
  end

  def action(conn, _) do apply(__MODULE__, action_name(conn),
    [conn, conn.params, Guardian.Plug.current_resource(conn)])
  end
end
