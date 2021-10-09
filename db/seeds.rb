admin = User.where(email: 'admin@example.com').first_or_create(
  password: '123456',
  full_name: 'Admin test',
  cpf: FFaker::IdentificationBR.cpf,
  cellphone: FFaker::PhoneNumber.short_phone_number,
  address: FFaker::Address.street_address,
  admin: true
)

regular = User.where(email: 'regular@example.com').first_or_create(
  password: '123456',
  full_name: 'Regular test',
  cpf: FFaker::IdentificationBR.cpf,
  cellphone: FFaker::PhoneNumber.short_phone_number,
  address: FFaker::Address.street_address
)

company = Company.where(name: 'Company test').first_or_create(
  cnpj: '99999999999999',
  active: true
)

company.users << [admin, regular]
