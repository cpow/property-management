defmodule LordCore.Repo.Migrations.CreateLegalEntities do
  use Ecto.Migration

  def change do
    create table(:legal_entities) do
      add :first_name, :string
      add :last_name, :string
      add :type, :string

      timestamps()
    end

  end
end
