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
alias LordCore.PropertyManager
alias LordCore.User


Repo.insert!(%User{
  first_name: "tophie",
  last_name: "bear",
  email: "cpow@example.com"
})

company = Repo.insert!(%Company{name: "first properties"})

Repo.insert!(%PropertyManager{
  first_name: "tophie",
  last_name: "bear",
  company_id: company.id,
})
