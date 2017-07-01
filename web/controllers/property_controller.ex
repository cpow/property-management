defmodule LordCore.PropertyController do
  use LordCore.Web, :controller
  import Ecto.Query, only: [from: 2]
  alias LordCore.Property

  plug Guardian.Plug.EnsureAuthenticated, [handler: LordCore.AuthErrorHandler]

  def index(conn, %{"company_id" => company_id}) do
    query = from p in Property, where: p.company_id == ^company_id

    properties = Repo.all(query)
    render(conn, "index.json-api", data: properties)
  end

  def create(conn, %{"property" => property_params}) do
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

  def show(conn, %{"id" => id}) do
    property = Repo.get!(Property, id)
    render(conn, "show.json-api", data: property)
  end

  def update(conn, %{"id" => id, "property" => property_params}) do
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

  def delete(conn, %{"id" => id}) do
    property = Repo.get!(Property, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(property)

    send_resp(conn, :no_content, "")
  end
end
