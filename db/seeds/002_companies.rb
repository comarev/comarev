company = Company.where(name: 'Company test').first_or_create(
  cnpj: FFaker::IdentificationBR.cnpj,
  phone: FFaker.numerify('#' * 14),
  discount: FFaker.rand(10),
  active: true
)

manager = User.find_by_email('manager@example.com')
regular = User.find_by_email('regular@example.com')

company.managers << manager
company.regulars << regular