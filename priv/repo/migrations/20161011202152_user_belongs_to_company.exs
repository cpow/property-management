defmodule LordCore.Repo.Migrations.UserBelongsToCompany do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :company_id, references(:companies)
    end

    create index(:users, [:company_id])
  end
end
