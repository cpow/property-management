defmodule LordCore.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :email, :string
      add :type, :string
      add :display_name, :string

      timestamps()
    end

  end
end
