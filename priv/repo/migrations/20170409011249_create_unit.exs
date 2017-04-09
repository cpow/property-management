defmodule LordCore.Repo.Migrations.CreateUnit do
  use Ecto.Migration

  def change do
    create table(:units) do
      add :unit_number, :string
      add :property_id, references(:properties)

      timestamps()
    end

    alter table(:users) do
      add :unit_id, references(:units)
    end

    create index(:units, [:property_id])
    create index(:users, [:unit_id])
  end
end
