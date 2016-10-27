defmodule LordCore.Repo.Migrations.UserBelongsToRole do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :role_id, references(:roles)
      add :company_id, references(:companies)
    end

    create index(:users, [:role_id])
    create index(:users, [:company_id])
  end
end
