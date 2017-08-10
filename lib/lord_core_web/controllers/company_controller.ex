defmodule LordCoreWeb.CompanyController do
  use LordCoreWeb, :controller
  alias LordCore.Company

  def index(conn, _params) do
    companies = Repo.all(Company)
    render(conn, "index.json-api", data: companies)
  end

  def create(conn, %{"company" => company_params}) do
    changeset = Company.changeset(%Company{}, company_params)

    case Repo.insert(changeset) do
      {:ok, company} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", company_path(conn, :show, company))
        |> render("show.json-api", data: company)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(LordCoreWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    company = Repo.get(Company, id)
    render(conn, "show.json-api", data: company)
  end

  def update(conn, %{"id" => id, "company" => company_params}) do
    company = Repo.get!(Company, id)
    changeset = Company.changeset(company, company_params)

    case Repo.update(changeset) do
      {:ok, company} ->
        render(conn, "show.json-api", data: company)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(LordCoreWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    company = Repo.get!(Company, id)
    Repo.delete!(company)

    send_resp(conn, :no_content, "")
  end
end
