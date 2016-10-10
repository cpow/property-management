defmodule LordCore.PropertyManagerController do
  use LordCore.Web, :controller

  alias LordCore.PropertyManager

  def index(conn, _params) do
    property_managers = Repo.all(PropertyManager)
    render(conn, "index.html", property_managers: property_managers)
  end

  def new(conn, _params) do
    changeset = PropertyManager.changeset(%PropertyManager{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"property_manager" => property_manager_params}) do
    changeset = PropertyManager.registration_changeset(
      %PropertyManager{}, property_manager_params)

    case Repo.insert(changeset) do
      {:ok, _property_manager} ->
        conn
        |> put_flash(:info, "Property manager created successfully.")
        |> redirect(to: property_manager_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    property_manager = Repo.get!(PropertyManager, id)
    render(conn, "show.html", property_manager: property_manager)
  end

  def edit(conn, %{"id" => id}) do
    property_manager = Repo.get!(PropertyManager, id)
    changeset = PropertyManager.changeset(property_manager)
    render(conn, "edit.html", property_manager: property_manager, changeset: changeset)
  end

  def update(conn, %{"id" => id, "property_manager" => property_manager_params}) do
    property_manager = Repo.get!(PropertyManager, id)
    changeset = PropertyManager.changeset(property_manager, property_manager_params)

    case Repo.update(changeset) do
      {:ok, property_manager} ->
        conn
        |> put_flash(:info, "Property manager updated successfully.")
        |> redirect(to: property_manager_path(conn, :show, property_manager))
      {:error, changeset} ->
        render(conn, "edit.html", property_manager: property_manager, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    property_manager = Repo.get!(PropertyManager, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(property_manager)

    conn
    |> put_flash(:info, "Property manager deleted successfully.")
    |> redirect(to: property_manager_path(conn, :index))
  end
end
