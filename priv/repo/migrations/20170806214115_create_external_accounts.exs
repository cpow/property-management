defmodule LordCore.Repo.Migrations.CreateExternalAccounts do
  use Ecto.Migration

  def change do
    create table(:external_accounts) do
      add :token, :string

      timestamps()
    end

  end
end
