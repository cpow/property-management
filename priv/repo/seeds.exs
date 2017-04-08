company = LordCore.Factory.insert(:company, name: "first properties")

property = LordCore.Factory.insert(:property,
  name: "brittin ave",
  address: "32 brittin ave",
  city: "bridgeport",
  state: "CT",
  zip: "06605",
  company_id: company.id
)

LordCore.Factory.insert(:user,
  first_name: "tophie",
  last_name: "bear",
  username: "manager1234",
  email: "manager@example.com",
  password_hash: Comeonin.Bcrypt.hashpwsalt("test1234"),
  role: "manager",
  company_id: company.id
)

LordCore.Factory.insert(:user,
  first_name: "tenant",
  first_name: "tenant",
  last_name: "person",
  username: "tenant1234",
  email: "tenant@example.com",
  password_hash: Comeonin.Bcrypt.hashpwsalt("test1234"),
  role: "tenant",
  property_id: property.id
)
