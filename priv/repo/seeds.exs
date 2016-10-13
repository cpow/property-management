# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LordCore.Repo.insert!(%LordCore.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias LordCore.Repo
alias LordCore.Company
alias LordCore.User
alias LordCore.Role

#Create all Roles that are needed in the application to get started
mgmt_role = Repo.insert!(%Role{name: "Property Manager", admin: false})
Repo.insert!(%Role{name: "Tenant", admin: false})
Repo.insert!(%Role{name: "Administrator", admin: true})

company = Repo.insert!(%Company{name: "first properties"})

property_manager = %User{}
|> User.registration_changeset(%{
  first_name: "tophie",
  last_name: "bear",
  username: "manager1234",
  email: "manager@example.com",
  password: "test1234",
  password_confirmation: "test1234",
  role_id: mgmt_role.id,
  company_id: company.id
})
|> Repo.insert!
