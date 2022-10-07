admin = User.where(email: 'admin@example.com').first_or_create(
  password: '123456',
  full_name: 'Admin test',
  cpf: FFaker::IdentificationBR.cpf,
  cellphone: FFaker.numerify('#' * 15),
  address: FFaker::Address.street_address,
  admin: true
)

manager = User.where(email: 'manager@example.com').first_or_create(
  password: '123456',
  full_name: 'Manager test',
  cpf: FFaker::IdentificationBR.cpf,
  cellphone: FFaker.numerify('#' * 15),
  address: FFaker::Address.street_address
)

regular = User.where(email: 'regular@example.com').first_or_create(
  password: '123456',
  full_name: 'Regular test',
  cpf: FFaker::IdentificationBR.cpf,
  cellphone: FFaker.numerify('#' * 15),
  address: FFaker::Address.street_address
)

customer = User.where(email: 'customer@example.com').first_or_create(
  password: '123456',
  full_name: 'Customer test',
  cpf: FFaker::IdentificationBR.cpf,
  cellphone: FFaker.numerify('#' * 15),
  address: FFaker::Address.street_address
)
