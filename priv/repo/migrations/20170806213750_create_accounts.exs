defmodule LordCore.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :email, :string
      add :type, :string
      add :display_name, :string
      add :user_id, references(:users, on_delete: :nothing)
      add :company_id, references(:companies, on_delete: :nothing)

      timestamps()
    end
    create index(:accounts, [:user_id])
    create index(:accounts, [:company_id])
  end
end
