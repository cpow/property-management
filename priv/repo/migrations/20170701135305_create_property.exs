defmodule LordCore.Repo.Migrations.CreateProperty do
  use Ecto.Migration

  def change do
    create table(:properties) do
      add :name, :string
      add :address, :string
      add :city, :string
      add :state, :string
      add :zip, :string
      add :company_id, references(:companies, on_delete: :nothing)

      timestamps()
    end
    create index(:properties, [:company_id])

  end
end
