defmodule LordCore.Factory do
  use ExMachina.Ecto, repo: LordCore.Repo

  def company_factory do
    %LordCore.Company{
      name: sequence("some property management company")
    }
  end

  def property_factory do
    %LordCore.Property{
      name: "first property",
      address: "34 brittin ave",
      city: "Bridgeport",
      state: "CT",
      zip: "06605",
    }
  end

  def user_factory do
    %LordCore.User{
      email: sequence("user@example.com"),
      first_name: "chris",
      last_name: "power",
      username: "cpow85",
      password_hash: Comeonin.Bcrypt.hashpwsalt("something"),
      role: "tenant"
    }
  end

  def unit_factory do
    %LordCore.Unit{
      unit_number: "424"
    }
  end
end
