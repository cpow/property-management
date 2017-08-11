company = LordCore.Factory.insert(:company, name: "first properties")

LordCore.Factory.insert(:property,
  name: "32-34 brittin ave",
  address: "32-34 brittin ave",
  city: "Bridgeport",
  state: "CT",
  zip: "06605",
  company: company
)

LordCore.Factory.insert(:user,
  first_name: "tophie",
  last_name: "bear",
  username: "manager1234",
  email: "manager@example.com",
  password_hash: Comeonin.Bcrypt.hashpwsalt("test1234"),
  role: "manager",
  company: company
)

LordCore.Factory.insert(:user,
  first_name: "tenant",
  first_name: "tenant",
  last_name: "person",
  username: "tenant1234",
  email: "tenant@example.com",
  password_hash: Comeonin.Bcrypt.hashpwsalt("test1234"),
  role: "tenant",
)
