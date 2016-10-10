defmodule LordCore.Factory do
  use ExMachina.Ecto, repo: LordCore.Repo

  def company_factory do
    %LordCore.Company{
      name: "some property management company"
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
