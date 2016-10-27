defmodule LordCore.Repo.Migrations.AddPropertyIdToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :property_id, references(:properties)
    end

    create index(:users, [:property_id])
  end
end
