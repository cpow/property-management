defmodule LordCore.Repo.Migrations.CreateProperties do
  use Ecto.Migration

  def change do
    create table(:properties) do
      add :name, :string
      add :address, :string
      add :city, :string
      add :state, :string
      add :zip, :string
      add :company_id, references(:companies)

      timestamps()
    end

    create index(:properties, [:company_id])
  end
end
