defmodule LordCore.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :password_hash, :string
      add :username, :string
      add :first_name, :string
      add :last_name, :string

      timestamps()
    end
  end
end
