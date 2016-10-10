defmodule LordCore.Factory do
  use ExMachina.Ecto, repo: LordCore.Repo

  def company_factory do
    %LordCore.Company{
      name: "some property management company"
    }
  end

  def user_factory do
    %LordCore.User{
      email: "user@example.com",
      first_name: "chris",
      last_name: "power",
      username: "cpow85",
      email: "manager@example.com",
      password_hash: "something",
    }
  end

  def property_manager_factory do
    %LordCore.PropertyManager{
      first_name: "chris",
      last_name: "power",
      email: "manager@example.com",
      company: build(:company),
      password_hash: "something",
    }
  end
end
