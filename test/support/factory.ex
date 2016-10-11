defmodule LordCore.Factory do
  use ExMachina.Ecto, repo: LordCore.Repo

  def company_factory do
    %LordCore.Company{
      name: sequence("some property management company")
    }
  end

  def role_factory do
    %LordCore.Role{
      name: sequence("Role"),
      admin: false
    }
  end

  def user_factory do
    %LordCore.User{
      email: sequence("user@example.com"),
      first_name: "chris",
      last_name: "power",
      username: "cpow85",
      password_hash: Comeonin.Bcrypt.hashpwsalt("something"),
      role: insert(:role)
    }
  end
end
